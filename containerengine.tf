
resource oci_containerengine_cluster OCI-Dev-Cluster {
  compartment_id = var.compartment_ocid
  kubernetes_version = data.oci_containerengine_node_pool_option.pool1_option.kubernetes_versions.2
  name               = "OCI-Dev-Cluster"
  vcn_id = oci_core_vcn.oke-vcn.id
  options {
    add_ons {
      is_kubernetes_dashboard_enabled = "true"
      is_tiller_enabled               = "true"
    }
    admission_controller_options {
      is_pod_security_policy_enabled = "false"
    }
    kubernetes_network_config {
      pods_cidr     = "10.244.0.0/16"
      services_cidr = "10.96.0.0/16"
    }
    service_lb_subnet_ids = [
      oci_core_subnet.oke-svclbsubnet-regional.id,
    ]
  }
  
}

resource oci_containerengine_node_pool pool1 {
  cluster_id     = oci_containerengine_cluster.OCI-Dev-Cluster.id
  compartment_id = var.compartment_ocid
  kubernetes_version = data.oci_containerengine_node_pool_option.pool1_option.kubernetes_versions.2
  name               = "pool1"
  node_shape = "VM.Standard1.2"

  node_config_details {
    placement_configs {
      availability_domain = data.oci_identity_availability_domain.AD-1.name
      subnet_id           = oci_core_subnet.oke-subnet-regional.id
    }
    placement_configs {
      availability_domain = data.oci_identity_availability_domain.AD-2.name
      subnet_id           = oci_core_subnet.oke-subnet-regional.id
    }
    placement_configs {
      availability_domain = data.oci_identity_availability_domain.AD-3.name
      subnet_id           = oci_core_subnet.oke-subnet-regional.id
    }
    size = "3"
  }
  
  node_source_details {
    
    image_id    = data.oci_containerengine_node_pool_option.pool1_option.sources.0.image_id
    source_type = data.oci_containerengine_node_pool_option.pool1_option.sources.0.source_type
    boot_volume_size_in_gbs = 60
  }
  #ssh_public_key      = var.node_pool_ssh_public_key
}

data oci_containerengine_node_pool_option pool1_option {
    node_pool_option_id = "all"
    compartment_id = var.compartment_ocid
}
