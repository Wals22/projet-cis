resource "aws_key_pair" "key" {
  key_name   = "key_pair"
  public_key = file("${path.module}/../../keys/id_rsa.pub")
}
