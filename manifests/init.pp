node default {

  include banner

  $profiles = hiera('profiles')
  contain($profiles)
}

