Vagrant.configure("2") do |config|

  config.vm.define "web01" do |web01|
      web01.vm.box = "ubuntu/bionic64"
      web01.vm.network "private_network", ip: "192.168.30.25"

      web01.vm.provider "virtualbox" do |vb|
          vb.memory = "2048"
          vb.cpus = 2
      end

      web01.vm.provision "shell", inline: <<-SHELL
          # installing java JDK
          sudo apt-get update -y
          sudo apt install default-jre wget -y
          sudo apt install default-jdk -y
          sudo apt-get update -y

          # install Jenkins
          wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add - -y
          sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list' 
          sudo apt-get update -y
          sudo apt install jenkins

          # Start Jenkins server
          sudo systemctl start jenkins
          sudo systemctl status jenkins

          # Open firewall for jenkins 
          sudo ufw allow 8080
          sudo ufw allow OpenSSH
          sudo ufw enable
          sudo ufw enable

      SHELL
  end
end
