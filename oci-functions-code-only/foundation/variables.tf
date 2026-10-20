variable "tenancy_ocid" {
  type        = string
  description = "Tenancy OCID. Resource Manager prepopulates this; never enter credentials."
  validation {
    condition     = can(regex("^ocid1.tenancy.", var.tenancy_ocid))
    error_message = "Use a tenancy OCID."
  }
}
variable "compartment_ocid" {
  type        = string
  description = "Existing, isolated learner compartment. Do not use the tenancy root or a shared production compartment."
  validation {
    condition     = can(regex("^ocid1.compartment.", var.compartment_ocid))
    error_message = "Use an existing non-root compartment OCID."
  }
}
variable "region" {
  type        = string
  default     = "us-chicago-1"
  description = "Workload region. This workshop is validated in Chicago."
}
variable "home_region" {
  type        = string
  description = "The tenancy HOME region, used for IAM writes; it can differ from Chicago."
}
variable "name_prefix" {
  type        = string
  default     = "inventory"
  description = "Lowercase lab prefix. A compartment-derived suffix makes names distinct across learner compartments."
  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,19}$", var.name_prefix))
    error_message = "Use 3-20 lowercase letters, digits, or hyphens, starting with a letter."
  }
}
variable "create_runtime_iam" {
  type        = bool
  default     = false
  description = "ADMIN ONLY: create the function dynamic group and runtime policies. Otherwise an administrator must install the output rule/statements separately before learners start."
}
