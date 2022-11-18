resource "oci_media_services_stream_distribution_channel" "demo_stream_distribution_channel" {
  compartment_id = var.compartment_id
  display_name   = "Demo Distribution Channel"
}

resource "oci_media_services_stream_cdn_config" "demo_stream_cdn_config" {
  config {
    type = "EDGE"
  }
  display_name            = "EDGE_CDN"
  distribution_channel_id = oci_media_services_stream_distribution_channel.demo_stream_distribution_channel.id
}

resource "oci_media_services_stream_packaging_config" "demo_stream_packaging_config" {
  display_name            = "Demo Packaging Configuration"
  distribution_channel_id = oci_media_services_stream_distribution_channel.demo_stream_distribution_channel.id
  segment_time_in_seconds = "6"
  stream_packaging_format = "HLS"
  encryption {
    algorithm = "NONE"
  }
}
