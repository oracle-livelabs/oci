# Copyright (c) 2024, 2026, Oracle and/or its affiliates. All rights reserved.
# The Universal Permissive License (UPL), Version 1.0 as shown at https://oss.oracle.com/licenses/upl/

terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

locals {
  vcns              = [for vcn in var.vcn_params : split("/", vcn.vcn_cidr)[1] < 16 || split("/", vcn.vcn_cidr)[1] > 30 ? file(format("\n\nERROR: The VCN Cidr %s for VCN %s is not between /16 and /30", vcn.vcn_cidr, vcn.display_name)) : null]
  subnets           = [for subnet in var.subnet_params : split("/", subnet.cidr_block)[1] < 16 || split("/", subnet.cidr_block)[1] > 30 ? file(format("\n\nERROR: The Subnet Cidr %s for Subnet %s is not between /16 and /30", subnet.cidr_block, subnet.display_name)) : null]
  protocols         = ["all", "1", "6", "17", "58"]
  sec_lists_ingress = [for sec_lists in var.sl_params : [for ingress in sec_lists.ingress_rules : contains(local.protocols, ingress.protocol) ? null : file(format("\n\nERROR: The protocol %s for the security list %s for ingress rules is not allowed. Supported options are all (all), 1 (ICMP), 6 (TCP), 17 (UDP), 58 (ICMPv6)", ingress.protocol, sec_lists.display_name))]]
  sec_lists_egress  = [for sec_lists in var.sl_params : [for egress in sec_lists.egress_rules : contains(local.protocols, egress.protocol) ? null : file(format("\n\nERROR: The protocol %s for the security list %s for egress rules is not allowed. Supported options are all (all), 1 (ICMP), 6 (TCP), 17 (UDP), 58 (ICMPv6)", egress.protocol, sec_lists.display_name))]]
}

resource "oci_core_virtual_network" "vcn" {
  for_each       = var.vcn_params
  cidr_block     = each.value.vcn_cidr
  compartment_id = var.compartment_ids[each.value.compartment_name]
  display_name   = each.value.display_name
  dns_label      = each.value.dns_label
}

resource "oci_core_internet_gateway" "igw" {
  for_each       = var.igw_params
  compartment_id = oci_core_virtual_network.vcn[each.value.vcn_name].compartment_id
  vcn_id         = oci_core_virtual_network.vcn[each.value.vcn_name].id
  display_name   = each.value.display_name
}

resource "oci_core_nat_gateway" "ngw" {
  for_each       = var.ngw_params
  compartment_id = oci_core_virtual_network.vcn[each.value.vcn_name].compartment_id
  vcn_id         = oci_core_virtual_network.vcn[each.value.vcn_name].id
  display_name   = each.value.display_name
}


resource "oci_core_route_table" "route_table" {
  for_each       = var.rt_params
  compartment_id = oci_core_virtual_network.vcn[each.value.vcn_name].compartment_id
  vcn_id         = oci_core_virtual_network.vcn[each.value.vcn_name].id
  display_name   = each.value.display_name

  dynamic "route_rules" {
    iterator = rr
    for_each = each.value.route_rules
    content {
      destination       = rr.value.destination
      network_entity_id = rr.value.use_igw ? oci_core_internet_gateway.igw[lookup(rr.value, "igw_name", null)].id : oci_core_nat_gateway.ngw[lookup(rr.value, "ngw_name", null)].id
    }
  }
}

resource "oci_core_security_list" "sl" {
  for_each       = var.sl_params
  compartment_id = oci_core_virtual_network.vcn[each.value.vcn_name].compartment_id
  vcn_id         = oci_core_virtual_network.vcn[each.value.vcn_name].id
  display_name   = each.value.display_name

  dynamic "egress_security_rules" {
    iterator = egress_rules
    for_each = each.value.egress_rules
    content {
      stateless   = egress_rules.value.stateless
      protocol    = egress_rules.value.protocol
      destination = egress_rules.value.destination
    }
  }


  dynamic "ingress_security_rules" {
    iterator = ingress_rules
    for_each = each.value.ingress_rules
    content {
      stateless   = ingress_rules.value.stateless
      protocol    = ingress_rules.value.protocol
      source      = ingress_rules.value.source
      source_type = ingress_rules.value.source_type

      dynamic "tcp_options" {
        iterator = tcp_options
        for_each = (lookup(ingress_rules.value, "tcp_options", null) != null) ? ingress_rules.value.tcp_options : []
        content {
          max = tcp_options.value.max
          min = tcp_options.value.min
        }
      }

      dynamic "udp_options" {
        iterator = udp_options
        for_each = (lookup(ingress_rules.value, "udp_options", null) != null) ? ingress_rules.value.udp_options : []
        content {
          max = udp_options.value.max
          min = udp_options.value.min
        }
      }
    }
  }
}



resource "oci_core_subnet" "subnets" {
  for_each                   = var.subnet_params
  cidr_block                 = each.value.cidr_block
  display_name               = each.value.display_name
  dns_label                  = lower(each.value.dns_label)
  prohibit_public_ip_on_vnic = each.value.is_subnet_private
  compartment_id             = oci_core_virtual_network.vcn[each.value.vcn_name].compartment_id
  vcn_id                     = oci_core_virtual_network.vcn[each.value.vcn_name].id
  route_table_id             = oci_core_route_table.route_table[each.value.rt_name].id
  security_list_ids          = [oci_core_security_list.sl[each.value.sl_name].id]
}
