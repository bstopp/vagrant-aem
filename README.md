# vagrant-aem - Vagrant boxes for AEM

#### Table of Contents

1. [Overview](#overview)
  * [Example Scenarios](#examples)
1. [Usage](#usage)
  * [Prerequisites](#prerequisites)
  * [Setup](#setup)
  * [Setup Parameters](#setup-parameters)
  * [Vagrant](#vagrant)
1. [Host System](#host-system)
  * [System Requirements](#system-requirements)
  * [Cautions](#cautions)
1. [Guest System](#guest-system)
  * [Running Applications](#running-applications)
  * [Access Points](#access-points)
1. [Contributing](#development)


## Overview

This project is a tool to help developers manage virtual machines contianing AEM instances. It is designed to allow quick setup and creation of vagrant images with a full AEM stack: Author, Publish, & Dispatcher.

### Examples

This is an example for the use of this project, there are two roles in it's use:

**Team Lead Tasks**

  1. A new project is tasked to a development team. 
  1. Team lead forks the project and clones it to local system.
  1. Lead creates a branch for the new project/client.
  1. Lead runs the setup script providing responses or a manually managed parameter file.
  1. The setup creates the appropriate Vagrant file, Puppet site manifest, and other necessary files.
  1. Lead edits the gitignore files to allow for check-in of the files created by the setup process.
  1. Lead commits & pushes the branch out.
  1. Run `vagrant up` and create a new VM for development.

**Team Member Tasks**
  1. Clones forked project and switches to new branch.
  1. Run `vagrant up` and create a new VM for development.

The end result is a standard work environment for the entire team, one that hopefully matches the Development environment. 

## Usage

### Prerequisites

 **Supporting Software**
 1. Vagrant (v1.8.4)
   1. Do not use v1.8.5; it has an [issue when updating the authorized keys](https://github.com/mitchellh/vagrant/issues/7610).


 **Required**
  1. AEM Quickstart jar file
  1. AEM [Dispatcher module](https://www.adobeaemcloud.com/content/companies/public/adobe/dispatcher/dispatcher.html) for your web server
  1. AEM License Key for your client
  
  
 **Optional**
  1. Java JDK that is required for your client. [Java](http://www.oracle.com/technetwork/java/index.html) or [OpenJDK](http://openjdk.java.net/)
  1. Custom dispatcher.any file

### Setup

There are two options for preparing the vagrant configuration: Answering questions during setup or creating a parameter file.

#### Setup with Prompts

There is a setup script which will prompt for necessary configuration needs. This script will prepare the templated files so Vagrant will provision the system correct. Usage from root folder:

~~~
> setup/setup.rb
~~~

This will create a file *./setup/parameters.json* containing the responses. This allows for other teams to quickly reuse an existing configuration. 

#### Setup with Parameter File

The setup script will output all answers to the prompted questions to a file for future use. This file can also be manually created and specified as a parameter to the setup script:

~~~
> setup/setup.rb setup/parameters.json
~~~

Doing so will read the file, and configure the setup accordingly. If any required parameter is missing, that item will be requested via a prompt.

**Keep in mind that the setup process will replace all contents of the parameter file with the new information.**

This is an example of a file which shows format and parameters:

~~~
{
  "client" : "test",
  "jdk_pkg" : "",
  "aem_jar" : "/path/to/aem-quickstart-6.1.jar",
  "dispatcher_mod" : "/path/to/dispatcher-apache2.4-4.1.10.so",
  "dispatcher_any" : ""
}

~~~

### Setup Parameters

The following are the parameters which are needed in order to setup the Vagrant and puppet configuration files. They are propmpted for in the script and used in the JSON parameter file:

##### `client`

**Required**. This is the name of the client for which the VM is intended. This is used as way to distinguish this system from others on the host. It affects:

  * VM name in VirtualBox
  * Host name for accessing dispatcher content (See [Access Points](#access-points)).
  * Docroot in the HTTP Server configurations.

Format: Any valid string.

##### `jdk_pkg`

Optional. This specifies the package to use when installing the JDK. If not provided, the default JDK for the system will be used. Format: fully qualified path to file.

##### `aem_jar`

**Required**. This specifies the location of the AEM installation jar. This file is not provided as part of this project, and must be provided by the consumer. Format: fully qualified path to file.

##### `aem_license`

**Required**. This is the license key for running the AEM system. Format: String.

##### `dispatcher_mod`

**Required**. This specifies the location of the AEM dispatcher module. This file is not provided as part of this project, and must be provided by the consumer. Format: fully qualified path to file.

##### `dispatcher_any`

Optional. This is a dispatcher.any file which can be specified for use, instead of the [default template](setup/templates/dispatcher.any.erb) Format: fully qualified path to file.

### Vagrant

#### VM Initialization

Once the setup has been accomplished, the vagrant system can be started:

~~~
> vagrant up
~~~

This step will take time to run, as it is configuring and setting up all of the software on the guest. 

#### VM Re-provisioning

If there is an update to the setup defintions, then a system reprovision may be required. This is as simple as executing this command while the VM is running:

~~~
> vagrant provision
~~~

## Host System

### System Requirements

Because of the number of applications running inside the guest, the definition is configured to consume a relatively large amount of system resources. It is recommended that the host sytem have:

  * 4 CPUs (or cores)
  * 16 GB of RAM
  * 100 GB free disk space

### Consumer Provided

The following items are required for the setup process, and are not provided by this project:

  * AEM Quickstart Jar
  * Dispatcher Module

### Cautions

The following ports are forwarded to the guest VM. If any are unavailable, the guest system may not start corrrectly: 

  * 4502
  * 4503
  * 10080
  * 18080
  * 18009
  * 30300
  * 30303
  * 30304

## Guest System

### Running Applications

The following applications are running by default:

  * HTTP Server
    * w/ dispatcher module
  * AEM Author 
  * AEM Publish

### Access Points

Most of the systems inside the VM are accessible using two different URLs. This is due to possible cookie issues when using just host/port combination, therefore named virtual hosts are also provided.

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
  * http://&lt;&lt;client&gt;&gt;.localhost:10080

## Development

This project was the driver behind the Puppet AEM module. As new features are added to that module, this project will be updated to incorporate their use for standarization of environments.

Contributions are always welcome, however please ensure that no AEM Quickstar jars or license keys are included in pull requests.
