# Vagrant AEM


This project is a tool to help developers manage virtual machines contianing AEM instances. It is designed to allow quick setup and creation of vagrant images with a full AEM stack: Author, Publish, & Dispatcher.

## How to Use

Run setup or create JSON parameters file.


#### Cautions
Please be aware that vagrant is expecting the following ports to be available for forwarding to the guest, if they are not available errors may occur.
* 10080
* 18080
* 18009
* 4502
* 4503
* 30300
* 30303
* 30304

## What's in the box



## Access Points
Most of the systems inside the VM are accessible using two different URLs. This is due to the possibility of experiencing cookie issues when using just host/port combination, therefore named virtual hosts are also provided.

#### AEM Author
##### Web Interface
* [http://localhost:4502/](http://localhost:4502/)
* [http://author.localhost:10080/](http://author.localhost:10080/)

##### Debugging
Debugging is enabled by default on the Author system, connect using port 30303.

#### AEM Publish
##### Web Interface
* [http://localhost:4503/](http://localhost:4503/)
* [http://publish.localhost:10080/](http://publish.localhost:10080/)

##### Debugging
Debugging is enabled by default on the Author system, connect using port 30304.

#### Client Site (HTTP Server)
* [http://localhost:10080](http://localhost:10080)
* http://&lt;&ltclient&gt;&gt;.localhost:10080


# TODO
Add SSL option?

