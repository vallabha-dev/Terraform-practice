module "dev" {
  source = "../Day-7-modules-source"
  ami-id = "ufduydfdfsf"
  instance-type = "t2.medium"
  name = "test"
}