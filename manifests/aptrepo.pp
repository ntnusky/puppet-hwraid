#
# == Class: hwraid::aptrepo
#
# Set up the HWRAID apt repository:
#
# <http://hwraid.le-vert.net/>
#
# <https://github.com/eLvErDe/hwraid>
#
class hwraid::aptrepo
(
    Enum['present','absent'] $ensure,
    String $key_id = '9B241597ACC8C086A363535E43676E103A9A6F7C'
)
{
    include ::apt

    $distrib = downcase($::operatingsystem)

    # Currently there are no packages for Ubuntu 14.04 or Debian 8, so we need 
    # to adapt accordingly.
    # LEP 05.06.19: Dirty hack to use xenial repo on bionic, since there is no
    # packages for bionic at this given time.
    $release = $::lsbdistcodename ? {
        'trusty' => 'precise',
        'jessie' => 'wheezy',
        'jammy'  => 'focal',
        'noble'  => 'focal',
        default  => $::lsbdistcodename,
    }

    apt::source { 'hwraid.le-vert.net':
        ensure   => $ensure,
        location => "http://hwraid.le-vert.net/${distrib}",
        release  => $release,
        repos    => 'main',
        key      => {'id'    => $key_id,
                    'source' => 'http://hwraid.le-vert.net/debian/hwraid.le-vert.net.gpg.key' }
        }
}
