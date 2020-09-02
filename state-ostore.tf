terraform {
   backend "http" {
     address = "<PAR-URL>" 
     update_method = "PUT" 
   }
}
