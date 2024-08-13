  userdata = <<-USERDATA
    #!/bin/bash
    dnf update --releasever=latest -y
    # Logic of Application Server
  USERDATA