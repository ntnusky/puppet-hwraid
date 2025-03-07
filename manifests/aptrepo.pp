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
    Enum['present','absent'] $ensure
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
        default  => $::lsbdistcodename,
    }

    apt::source { 'hwraid.le-vert.net':
        ensure   => $ensure,
        location => "http://hwraid.le-vert.net/${distrib}",
        release  => $release,
        repos    => 'main',
        key      => {'id'    => '0073C11919A641464163F7116005210E23B3D3B4',
                    'source' => 'http://hwraid.le-vert.net/debian/hwraid.le-vert.net.gpg.key' }
        }
}
