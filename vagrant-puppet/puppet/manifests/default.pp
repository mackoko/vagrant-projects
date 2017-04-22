#include mysql
include stdlib
include apt

class { 'elasticsearch':
  java_install => true,
  manage_repo  => true,
  repo_version => '5.x',
}

elasticsearch::instance { 'es-01': }


# https://serverfault.com/questions/197909/puppet-class-inheritance-confusion
 #   import works with files, and does not execute classes
 #   include executes classes
 #   files must be imported before the classes can be included
