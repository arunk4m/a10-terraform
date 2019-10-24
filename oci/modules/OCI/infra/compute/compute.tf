variable "app_display_name" {
  default = ""
}

<<<<<<< HEAD
=======
variable "next_hop_ip" {
}
variable "client_vnic_private_ip" {
}


variable "floating_server_private_ip" {
}

variable "floating_client_private_ip" {
}

variable "mgmt_default_gateway" {
}

variable "client_vnic_private_ip2" {
}

variable "virtual_server_ip" {
}

variable "virtual_server_ip2" {
}

>>>>>>> 0c0f5adebe9a3d7bd8eeeb07581f184dd8545b46
variable "compartment_id" {
description = "Compartment OCID"
}

<<<<<<< HEAD
=======
variable "vnic_ip1" {
}

>>>>>>> 0c0f5adebe9a3d7bd8eeeb07581f184dd8545b46
variable "vm_availability_domain" {
description = "VM availability domain"
}

variable "vm_display_name1" {
description = "VM display name"
}
variable "vm_display_name2" {
description = "VM display name"
}

variable "vm_shape" {
description = "VM shape"
}

variable "vm_primary_vnic_display_name" {
description = "VM primary VNIC display name"
}

variable "vm_ssh_public_key_path" {
description = "VM ssh public key file path"
}

variable "vm_creation_timeout" {
description = "VM creation timeout"
}

variable "vm_app_shape" {
  default = "VM.Standard2.1"
}

variable "oci_subnet_id1" {
  description = "oci_subnet_id"
}

variable "oci_subnet_id3" {
  description = "oci_subnet_id"
}

variable "tenancy_ocid" {
description = "tenancy ocid"
}

variable "vThunder__image_ocid" {
}
variable "vm_count" {
  default = "1"
}

data "oci_core_images" "vThuder_image" {
  compartment_id = "${var.tenancy_ocid}"
 }
<<<<<<< HEAD

locals {
  vThunder__image_ocid = "${var.vThunder__image_ocid}"
}
=======
locals {
  vThunder__image_ocid = "${var.vThunder__image_ocid}"
  }
>>>>>>> 0c0f5adebe9a3d7bd8eeeb07581f184dd8545b46

resource "oci_core_instance" "vthunder_vm" {
  count = "${var.vm_count}"
  compartment_id = "${var.compartment_id}"

<<<<<<< HEAD
  display_name = "vthunder-vm-${count.index + 1}"
=======
  display_name = "vthunder-vm-${count.index}"
>>>>>>> 0c0f5adebe9a3d7bd8eeeb07581f184dd8545b46

  availability_domain = "${var.vm_availability_domain}"

  source_details {
    source_id = "${local.vThunder__image_ocid}"
    source_type = "image"
  }

  shape = "${var.vm_shape}"

  create_vnic_details {
    subnet_id = "${var.oci_subnet_id1}"
    display_name = "${var.vm_primary_vnic_display_name}"
    assign_public_ip = true
  }
  metadata {
    ssh_authorized_keys = "${file( var.vm_ssh_public_key_path )}"
  }
  timeouts {
    create = "${var.vm_creation_timeout}"
  }
}


##APP SERVER###

resource "oci_core_instance" "app-server" {
  compartment_id = "${var.compartment_id}"
  display_name = "${var.app_display_name}"
  availability_domain = "${var.vm_availability_domain}"

  source_details {
    source_id = "ocid1.image.oc1.iad.aaaaaaaaek6aecdnja3rc6qmimbv4x3cipl5b4mknkxlp4xqpmjbbv43dloa"
    source_type = "image"
  }

  shape = "${var.vm_app_shape}"

  create_vnic_details {
    subnet_id = "${var.oci_subnet_id3}"
    assign_public_ip = false  }
  metadata {
    ssh_authorized_keys = "${file( var.vm_ssh_public_key_path )}"
    user_data = "${base64encode(file("user_data.sh"))}"

  }
  timeouts {
    create = "${var.vm_creation_timeout}"
  }
}

<<<<<<< HEAD
=======


#bastion host temporary








>>>>>>> 0c0f5adebe9a3d7bd8eeeb07581f184dd8545b46
output "ip" {value = "${element(oci_core_instance.vthunder_vm.*.public_ip,1)}"}
output "ip2" {value = "${element(oci_core_instance.vthunder_vm.*.public_ip,2)}"}

output "backend_server_ip" {value = "${element(oci_core_instance.app-server.*.private_ip,0)}"}

output "instance_id" { value = "${element(oci_core_instance.vthunder_vm.*.id,1)}" }
output "instance_id2" { value = "${element(oci_core_instance.vthunder_vm.*.id,2)}" }
