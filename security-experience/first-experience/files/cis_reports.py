# copyright (c) 2016, 2020, Oracle and/or its affiliates.  All rights reserved.
# This software is dual-licensed to you under the Universal Permissive License (UPL) 1.0 as shown at https://oss.oracle.com/licenses/upl or Apache License 2.0 as shown at http://www.apache.org/licenses/LICENSE-2.0. You may choose either license.
#
# cis_reports.py
# @author base: Sonia Yuste Lledo
# @author: Sonia Yuste Lledo
#
# Supports Python 3 and above
#
# coding: utf-8
##########################################################################

from __future__ import print_function
import sys
import argparse
import datetime
import pytz
import oci
import json
import os
import csv


##########################################################################
# Security Assessment Reporting Class
##########################################################################
class Security_Assessment:

    security_services_checks = {
        '1': {'CHECK': 'Cloud Guard', 'Status': "DISABLED"},
        '2': {'CHECK': 'Vulnerability Scanning', 'Status': "DISABLED"},
        '3': {'CHECK': 'Bastion Service', 'Status': "DISABLED"},
        '4': {'CHECK': 'OCI Vault', 'Status': "DISABLED"},
        '5': {'CHECK': 'OCI Certificates', 'Status': "DISABLED"},
        '6': {'CHECK': 'Data Safe', 'Status': False},
        '7': {'CHECK': 'Web Application Firewall', 'Status': "DISABLED"},
         }

    # Class variables
    __home_region = []

    # For printing date
    start_date = str(datetime.datetime.now().strftime("%Y-%m-%d"))    

    # Tenancy Data
    __tenancy = None
    __cloud_guard_config = "DISABLED"

    # For Bastion Check
    __bastions = "DISABLED"

    # For Vulnerability Scanning Check
    __scan_hosts = "DISABLED"

    # For WAF Check
    __waf = "DISABLED"

    # For Compartments Count
    __compartments = []

    # For Vaults Checks
    __vaults = "DISABLED"

    # For Certificates checks
    __certificates = "DISABLED"

    # For Data Safe check
    __data_safe_conf = None

    # Start print time info
    start_datetime = datetime.datetime.now().replace(tzinfo=pytz.UTC)
    start_time_str = str(datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"))

    def __init__(self, config, signer, proxy, output_bucket, report_directory, print_to_screen):
        # Start print time info
        self.__print_header("Running OCI Security Assessment...")
        print("Updated January 11, 2022.")
        print("oci-python-sdk version 2.47.0")
        print("Starts at " + self.start_time_str)
        self.__config = config
        self.__signer = signer
        # Working with input variables from
        self.__output_bucket = output_bucket

        # By Default it is passed True to print all output
        if print_to_screen.upper() == 'TRUE':
            self.__print_to_screen = True
        else:
            self.__print_to_screen = False
        #Object definitions
        try:
            self.__identity = oci.identity.IdentityClient(
                self.__config, signer=self.__signer)
            if proxy:
                self.__identity.base_client.session.proxies = {'https':proxy}
           
            self.__os_client = oci.object_storage.ObjectStorageClient(
                self.__config, signer=self.__signer)
            if proxy:
                self.__os_client.base_client.session.proxies = {'https': proxy}            

            self.__cloud_guard = oci.cloud_guard.CloudGuardClient(
                self.__config, signer=self.__signer)
            if proxy:
                self.__cloud_guard.base_client.session.proxies = {
                    'https': proxy}

            self.__list_bastions = oci.bastion.BastionClient(
                self.__config, signer=self.__signer)
            if proxy:
                self.__list_bastions.base_client.session.proxies = {
                    'https': proxy}

            self.__scanning_hosts = oci.vulnerability_scanning.VulnerabilityScanningClient(
                self.__config, signer=self.__signer)
            if proxy:
                self.__scanning_hosts.base_client.session.proxies = {
                    'https':proxy}

            self.__vault = oci.key_management.KmsVaultClient(
                self.__config, signer=self.__signer)
            if proxy:
                self.__vault.session.proxies = {'https': proxy}

            self.__list_wafs = oci.waf.WafClient(
                self.__config, signer=self.__signer)
            if proxy:
                self.__list_wafs.base_client.session.proxies = {'https':proxy}

            self.__list_waas = oci.waas.WaasClient(
                self.__config, signer=self.__signer)
            if proxy:
                self.__list_waas.base_client.session.proxies = {'https':proxy}

            self.__client_certificates = oci.certificates_management.CertificatesManagementClient(
                self.__config, signer=self.__signer)
            if proxy:
                self.__client_certificates.base_client.session.proxies = {'https':proxy}

            self.__data_safe_client = oci.data_safe.DataSafeClient(
                self.__config, signer=self.__signer)
            if proxy:
                self.__data_safe_client.base_client.session.proxies = {'https':proxy}

            # Getting Tenancy Data and Region data
            self.__tenancy = self.__identity.get_tenancy(
                config["tenancy"]).data
            self.__regions = self.__identity.list_region_subscriptions(
                self.__tenancy.id).data

            for i in self.__regions:
              if i._is_home_region:      
                    
                    self.__home_region = i.region_name
                    print(  "Home region for tenancy is " + self.__home_region)
            
            # By Default it is today's date
            if report_directory:
                self.__report_directory = report_directory
            else:
                self.__report_directory = self.__tenancy.description + "-" + self.start_date

        except Exception as e:
            raise RuntimeError(
                "Failed to create service objects" + str(e.args))

    ##########################################################################
    # Check for Managed PaaS Compartment
    ##########################################################################
    def __if_not_managed_paas_compartment(self, name):
        return name != "ManagedCompartmentForPaaS"

    ##########################################################################
    # Load compartments
    ##########################################################################
    def __identity_read_compartments(self):

        print("Processing Compartments...")
        try:
            self.__compartments = oci.pagination.list_call_get_all_results(
                self.__identity.list_compartments,
                self.__tenancy.id,
                compartment_id_in_subtree=True
            ).data

            # Add root compartment which is not part of the list_compartments
            self.__compartments.append(self.__tenancy)
           
            return self.__compartments

        except Exception as e:
            raise RuntimeError(
                "Error in identity_read_compartments: " + str(e.args))
    
    ##########################################################################
    # Vaults
    ##########################################################################
    def __vault_read_vaults(self):
        print("Processing Vaults...")
        # Iterating through compartments
        try: 
            
            for compartment in self.__compartments:
                # Checking if Vault enabled found
                if self.__vaults == 'ENABLED':
                    break

                vaults_data = oci.pagination.list_call_get_all_results(self.__vault.list_vaults,compartment.id).data          
                for vlt in vaults_data:
                    # Checking for deleted Vaults
                    if vlt.lifecycle_state != 'DELETED' or vlt.lifecycle_state != 'DELETING':
                         self.__vaults = 'ENABLED'
                         break
                    else:
                        self.__vaults = 'DELETED'
                           
            return self.__vaults      

        except Exception as e:
            raise RuntimeError("Error in __vault_read_vaults " + str(e.args))

    ##########################################################################
    # Cloud Guard Configuration
    ##########################################################################
    def __cloud_guard_read_cloud_guard_configuration(self):
        print("Processing Cloud Guard Configuration...")
        try:
            for compartment in self.__compartments:
                self.__cloud_guard_config = self.__cloud_guard.get_configuration(compartment.id).data.status

                if compartment.id == self.__tenancy.id and self.__cloud_guard_config == 'DISABLED':
                    print("Cloud Guard is not enabled at root compartment level!") 

            return self.__cloud_guard_config
        except Exception as e:
            print("Cloud Guard service requires a PayGo account")
   
    ##########################################################################
    # Bastion list
    ##########################################################################
    def __bastion_list(self):
        print("Processing Bastions...")
        try: 
            for compartment in self.__compartments:
                # Checking if bastion enabled found
                if self.__bastions == 'ENABLED':
                    break

                # Getting bastions        
                bastions_data = oci.pagination.list_call_get_all_results(self.__list_bastions.list_bastions,compartment.id).data
                
                for bst in bastions_data:
                   # Checking bastions
                    if bst.lifecycle_state != 'DELETING' or bst.lifecycle_state != 'DELETED' or bst.lifecycle_state != 'FAILED':
                        self.__bastions = 'ENABLED'
                        break
                    elif bst.lifecycle_state == 'FAILED':
                        self.__bastions = 'DISABLED'
                    else:
                        self.__bastions = 'DELETED'

            return self.__bastions 


        except Exception as e:
            raise RuntimeError("Error in __bastion_list " + str(e.args))
	
    #######################################################################
    # Vulnerability Scanning
    ######################################################################
    def __VSS_host_recipes(self):
        print("Processing Vulnerability Scanning Recipes...")
        try:
            for compartment in self.__compartments:
             
                if self.__scan_hosts == 'ENABLED':
                    break                

                scan_hosts_data = oci.pagination.list_call_get_all_results(self.__scanning_hosts.list_host_scan_recipes,compartment.id).data

                for scanhosts in scan_hosts_data:
                    # Checking deleted scan host recipes
                    if scanhosts.lifecycle_state != 'DELETING' or scanhosts.lifecycle_state != 'DELETED' or scanhosts.lifecycle_state != 'FAILED':
                        self.__scan_hosts = 'ENABLED'
                        break
                    elif scanhosts.lifecycle_state == 'FAILED':
                        self.__scan_hosts = 'DISABLED'
                    else: 
                        self.__scan_hosts = 'DELETED'

                if self.__scan_hosts == 'ENABLED':
                    break

                scan_containers_data = oci.pagination.list_call_get_all_results(self.__scanning_hosts.list_container_scan_recipes,compartment.id).data
                
                for scancontainers in scan_hosts_data:
                    if scancontainers.lifecycle_state != 'DELETING' or scancontainers.lifecycle_state != 'DELETED' or scancontainers.lifecycle_state != 'FAILED':
                        self.__scan_hosts = 'ENABLED'
                        break
                    elif scancontainers.lifecycle_state == 'FAILED':
                        self.__scan_hosts = 'DISABLED'
                    else:
                        self.__scan_hosts = 'DELETED'

            return self.__scan_hosts
        except Exception as e:
            raise RuntimeError("Error in __VSS_host_recipes " + str(e.args))

    ##########################################################################
    # WAF
    #########################################################################
    def __WAF(self):
        print("Processing Web Application Firewalls...")
        try:
            for compartment in self.__compartments:
               # Skipping root compartment 
                if compartment.id != self.__tenancy.id and compartment.lifecycle_state == 'ACTIVE':

                    if self.__waf == 'ENABLED':
                        break

                    waf_policies_data = oci.pagination.list_call_get_all_results(self.__list_wafs.list_web_app_firewall_policies,compartment.id).data           
                     
                    for wafpol in waf_policies_data:
                        # Checking deleted waf policies
                        if wafpol.lifecycle_state != 'DELETING' or wafpol.lifecycle_state != 'DELETED' or wafpol.lifecycle_state != 'FAILED':
                            self.__waf = 'ENABLED'
                            break
                        elif wafpol.lifecycle_state == 'FAILED':
                            self.__waf = 'DISABLED'
                        else: 
                            self.__waf = 'DELETED'

                    if self.__waf == 'ENABLED':
                        break

                    waas_policies_data = oci.pagination.list_call_get_all_results(self.__list_waas.list_waas_policies,compartment.id).data

                    for waaspol in waas_policies_data:
                        # Checking deleted edge policies
                        if waaspol.lifecycle_state != 'DELETING' or waaspol.lifecycle_state != 'DELETED' or waaspol.lifcycle_state != 'FAILED':
                            self.__waf = 'ENABLED'
                            break
                        elif waaspol.lifecycle_state == 'FAILED':
                            self.__waf = 'DISABLED'
                        else:
                            self.__waf = 'DELETED'
              
            return self.__waf
        except Exception as e:
            raise RuntimeError("Error in __WAF " + str(e.args))     
   
    ##########################################################################
    # Certificates
    ###########################################################################
    def __all_certificates(self):
        print("Processing Certificates...")
        try:
            for compartment in self.__compartments:
              
                if self.__certificates == 'ENABLED':
                    break

                certificates_data = oci.pagination.list_call_get_all_results(self.__client_certificates.list_certificates,compartment_id=compartment.id).data
 
                for crts in certificates_data:
                    if crts.lifecycle_state != 'DELETING' or crts.lifecycle_state != 'DELETED' or crts.lifecycle_state != 'FAILED':
                        self.__certificates = 'ENABLED'
                        break
                    elif crts.lifecycle_state == 'FAILED':
                        self.__certificates = 'DISABLED'
                    else:
                        self.__certificates = 'DELETED'

                if self.__certificates == 'ENABLED':
                    break
            
                ca_data = oci.pagination.list_call_get_all_results(self.__client_certificates.list_certificate_authorities,compartment_id=compartment.id).data

                for cas in ca_data:
                    if cas.lifecycle_state != 'DELETING' or cas.lifecycle_state != 'DELETED' or cas.lifecycle_state != 'FAILED':
                        self.__certificates = 'ENABLED'
                        break
                    elif cas.lifecycle_state == 'FAILED':
                        self.__certificates = 'DISABLED'
                    else:
                        self.__certificates = 'DELETED'

                if self.__certificates == 'ENABLED':
                    break

                ca_bundles_data = oci.pagination.list_call_get_all_results(self.__client_certificates.list_ca_bundles,compartment_id=compartment.id).data

                for cab in ca_bundles_data:
                    if cab.lifecycle_state != 'DELETING' or cab.lifecycle_state != 'DELETED' or cab.lifecycle_state != 'FAILED':
                        self.__certificates = 'ENABLED'
                        break
                    elif cab.lifecycle_state == 'FAILED':
                        self.__certificates = 'DISABLED'
                    else:
                        self.__certificates = 'DELETED'
                    
            return self.__certificates
        except Exception as e:
            raise RuntimeError("Error in __all_certificates " + str(e.args))     

     ############################################################################
     # Data Safe
     ############################################################################
    def __data_safe(self):
        try:
            print("Processing Data Safe...")
            self.__data_safe_conf=self.__data_safe_client.get_data_safe_configuration(compartment_id=self.__tenancy.id).data.is_enabled
            return self.__data_safe_conf
        except Exception as e:
            raise RuntimeError("Error in __data_safe " + str(e.args)) 
     

    ##########################################################################
    # Analyzes Tenancy Data for OCI Security Assessment
    ##########################################################################
    def __report_analyze_tenancy_data(self):

        # Cloud Guard enabled
        if self.__cloud_guard_config == 'ENABLED':
            self.security_services_checks['1']['Status'] = 'ENABLED'
            
	# Bastion enabled
        if self.__bastions == 'ENABLED':
            self.security_services_checks['3']['Status'] = 'ENABLED'
        elif self.__bastions == 'DELETED':
            self.security_services_checks['3']['Status'] = 'DELETED'

       # VSS hosts enabled
        if self.__scan_hosts == 'ENABLED':
            self.security_services_checks['2']['Status'] = 'ENABLED'
        elif self.__scan_hosts == 'DELETED':
            self.security_services_checks['2']['Status'] = 'DELETED'

        # OCI Vault enabled
        if self.__vaults == 'ENABLED':
            self.security_services_checks['4']['Status'] = 'ENABLED'
        elif self.__vaults == 'DELETED':
            self.security_services_checks['4']['Status'] = 'DELETED'

        # WAF enabled
        if self.__waf == 'ENABLED':
            self.security_services_checks['7']['Status'] = 'ENABLED'
        elif self.__waf == 'DELETED':
            self.security_services_checks['7']['Status'] = 'DELETED'

        # OCI Certificates enabled
        if self.__certificates == 'ENABLED':
            self.security_services_checks['5']['Status'] = 'ENABLED'
        elif self.__certificates == 'DELETED':
            self.security_services_checks['5']['Status'] = 'DELETED'

        # Data Safe enabled
        if self.__data_safe_conf == True:
            self.security_services_checks['6']['Status'] = 'ENABLED'
        

    ##########################################################################
    # Orchestras data collection - analysis and report generation
    ##########################################################################

    def report_generate_security_assessment_report(self):
        # This function reports generates CSV reports

        # Collecting all the tenancy data
        self.__report_collect_tenancy_data()

        # Analyzing Data in reports
        self.__report_analyze_tenancy_data()

        # Creating summary report
        summary_report = []
        for key, recommendation in self.security_services_checks.items():
            record = {"ENABLED": recommendation['Status'],"CHECK": recommendation['CHECK']}
            # Add record to summary report for CSV output
            summary_report.append(record)

            # Generate Findings report
            # self.__print_to_csv_file("cis", recommendation['section'] + "_" + recommendat['recommendation_#'], recommendation['Findings'] )

        # Screen output for Security Checks Report
        self.__print_header("OCI Security Assessment Report")
        print("ENABLED" + "\t\t" + 'CHECK')
        print('#' * 90)
        for finding in summary_report:
            # If print_to_screen is False it will only print non-compliant findings
            if not(self.__print_to_screen) and finding['ENABLED'] == 'DISABLED':
                print(finding['ENABLED'] + "\t\t" + finding['CHECK'])
            elif self.__print_to_screen:
                print(finding['ENABLED'] + "\t\t" + finding['CHECK'])

        # Generating Summary report CSV
        self.__print_header("Writing reports to CSV")
        summary_file_name = self.__print_to_csv_file(
            self.__report_directory, "security", "assessment_report", summary_report)
        # Out putting to a bucket if I have one
        if summary_file_name and self.__output_bucket:
            self.__os_copy_report_to_object_storage(
                self.__output_bucket, summary_file_name)

        # for key, recommendation in self.cis_foundations_benchmark_1_1.items():
        #     report_file_name = self.__print_to_csv_file(
        #         self.__report_directory, "cis", recommendation['section'] + "_" + recommendation['recommendation_#'], recommendation['Findings'])
        #     if report_file_name and self.__output_bucket:
        #         self.__os_copy_report_to_object_storage(
        #             self.__output_bucket, report_file_name)

    def __report_collect_tenancy_data(self):

        self.__print_header("Processing Tenancy Data for " +
                            self.__tenancy.name + "...")

        self.__compartments = self.__identity_read_compartments()
        self.__cloud_guard_read_cloud_guard_configuration()
        self.__bastion_list()
        self.__VSS_host_recipes()
        self.__vault_read_vaults()
        self.__WAF()
        self.__all_certificates()
        self.__data_safe()

    ##########################################################################
    # Copy Report to Object Storage
    ##########################################################################
    def __os_copy_report_to_object_storage(self, bucketname, filename):
        object_name = filename
        # print(self.__os_namespace)
        # Getting namespace
        try:
            self.__os_namespace = self.__os_client.get_namespace().data
        except Exception as e:
            raise RuntimeError(
                "Error in __os_copy_report_to_obect_storage could not load namespace " + str(e.args))

        try:
            with open(filename, "rb") as f:
                try:
                    self.__os_client.put_object(
                        self.__os_namespace, bucketname, object_name, f)
                except Exception as e:
                    raise Exception(
                        "Error uploading file os_copy_report_to_object_storage: " + str(e.args))
        except Exception as e:
            raise Exception(
                "Error opening file os_copy_report_to_object_storage: " + str(e.args))

    ##########################################################################
    # Print to CSV
    ##########################################################################
    def __print_to_csv_file(self, report_directory, header, file_subject, data):

        try:
            # Creating report directory
            if not os.path.isdir(report_directory):
                os.mkdir(report_directory)

        except Exception as e:
            raise Exception(
                "Error in creating report directory: " + str(e.args))

        try:
            # if no data
            if len(data) == 0:
                return None

            # get the file name of the CSV

            file_name = header + "_" + file_subject
            file_name = (file_name.replace(" ", "_")
                         ).replace(".", "-") + ".csv"
            file_path = os.path.join(report_directory, file_name)

            # add start_date to each dictionary
            result = [dict(item, EXTRACT_DATE=self.start_time_str)
                      for item in data]

            # generate fields
            fields = [key for key in result[0].keys()]

            with open(file_path, mode='w', newline='') as csv_file:
                writer = csv.DictWriter(csv_file, fieldnames=fields)

                # write header
                writer.writeheader()

                for row in result:
                    writer.writerow(row)

            print("CSV: " + file_subject.ljust(22) + " --> " + file_path)
            # Used by Uplaoad to
            return file_path

        except Exception as e:
            raise Exception("Error in print_to_csv_file: " + str(e.args))

    ##########################################################################
    # Print header centered
    ##########################################################################
    def __print_header(self, name):
        chars = int(90)
        print("")
        print('#' * chars)
        print("#" + name.center(chars - 2, " ") + "#")
        print('#' * chars)

##########################################################################
# check service error to warn instead of error
##########################################################################


def check_service_error(code):
    return ('max retries exceeded' in str(code).lower() or
            'auth' in str(code).lower() or
            'notfound' in str(code).lower() or
            code == 'Forbidden' or
            code == 'TooManyRequests' or
            code == 'IncorrectState' or
            code == 'LimitExceeded'
            )

##########################################################################
# Create signer for Authentication
# Input - config_profile and is_instance_principals and is_delegation_token
# Output - config and signer objects
##########################################################################


def create_signer(config_profile, is_instance_principals, is_delegation_token):

    # if instance principals authentications
    if is_instance_principals:
        try:
            signer = oci.auth.signers.InstancePrincipalsSecurityTokenSigner()
            config = {'region': signer.region, 'tenancy': signer.tenancy_id}
            return config, signer

        except Exception:
            print("Error obtaining instance principals certificate, aborting")
            raise SystemExit

    # -----------------------------
    # Delegation Token
    # -----------------------------
    elif is_delegation_token:

        try:
            # check if env variables OCI_CONFIG_FILE, OCI_CONFIG_PROFILE exist and use them
            env_config_file = os.environ.get('OCI_CONFIG_FILE')
            env_config_section = os.environ.get('OCI_CONFIG_PROFILE')

            # check if file exist
            if env_config_file is None or env_config_section is None:
                print(
                    "*** OCI_CONFIG_FILE and OCI_CONFIG_PROFILE env variables not found, abort. ***")
                print("")
                raise SystemExit

            config = oci.config.from_file(env_config_file, env_config_section)
            delegation_token_location = config["delegation_token_file"]

            with open(delegation_token_location, 'r') as delegation_token_file:
                delegation_token = delegation_token_file.read().strip()
                # get signer from delegation token
                signer = oci.auth.signers.InstancePrincipalsDelegationTokenSigner(
                    delegation_token=delegation_token)

                return config, signer

        except KeyError:
            print("* Key Error obtaining delegation_token_file")
            raise SystemExit

        except Exception:
            raise

    # -----------------------------
    # config file authentication
    # -----------------------------
    else:
        try:
            config = oci.config.from_file(
                oci.config.DEFAULT_LOCATION,
                (config_profile if config_profile else oci.config.DEFAULT_PROFILE)
            )
            signer = oci.signer.Signer(
                tenancy=config["tenancy"],
                user=config["user"],
                fingerprint=config["fingerprint"],
                private_key_file_location=config.get("key_file"),
                pass_phrase=oci.config.get_config_value_or_default(
                    config, "pass_phrase"),
                private_key_content=config.get("key_content")
            )
            return config, signer
        except Exception:
            print(
                f'** OCI Config was not found here : {oci.config.DEFAULT_LOCATION} or env varibles missing, aborting **')
            raise SystemExit


##########################################################################
# Arg Parsing function to be updated
##########################################################################
def set_parser_arguments():

    parser = argparse.ArgumentParser()
    parser.add_argument(
        '-i',
        type=argparse.FileType('r'),
        dest='input',
        help="Input JSON File"
    )
    parser.add_argument(
        '-o',
        type=argparse.FileType('w'),
        dest='output_csv',
        help="CSV Output prefix")
    result = parser.parse_args()

    if len(sys.argv) < 3:
        parser.print_help()
        return None

    return result

##########################################################################
# execute_report
##########################################################################
def execute_report():
    
    parser = argparse.ArgumentParser()
    parser.add_argument('-t', default="", dest='config_profile',
                        help='Config file section to use (tenancy profile)')
    parser.add_argument('-p', default="", dest='proxy',
                        help='Set Proxy (i.e. www-proxy-server.com:80) ')
    parser.add_argument('--output-to-bucket', default="", dest='output_bucket',
                        help='Set Output bucket name (i.e. my-reporting-bucket) ')
    parser.add_argument('--report-directory', default=None, dest='report_directory',
                        help='Set Output report directory by default it is the current date (i.e. reports-date) ')
    parser.add_argument('--print-to-screen', default='True', dest='print_to_screen',
                        help='Set to False if you want to see only non-compliant findings (i.e. False) ')
    parser.add_argument('-ip', action='store_true', default=False,
                        dest='is_instance_principals', help='Use Instance Principals for Authentication')
    parser.add_argument('-dt', action='store_true', default=False,
                        dest='is_delegation_token', help='Use Delegation Token for Authentication')
    cmd = parser.parse_args()
    # Getting  Command line  arguments
    # cmd = set_parser_arguments()
    # if cmd is None:
    #     pass
    #     # return

    # Identity extract compartments
    config, signer = create_signer(
        cmd.config_profile, cmd.is_instance_principals, cmd.is_delegation_token)
    report = Security_Assessment(config, signer, cmd.proxy, cmd.output_bucket,
                        cmd.report_directory, cmd.print_to_screen)

    report.report_generate_security_assessment_report()


##########################################################################
# Main
##########################################################################

execute_report()






