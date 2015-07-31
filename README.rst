=========
wstool_cd
=========
``cd`` to repositories in workspace which is managed by `vcstools/wstool <https://github.com/vcstools/wstool>`_.


Installation
============
install via pypi::

    $ pip install wstool_cd

add following to your `.bashrc` or `.zshrc`::

    source `which wstool_cd.sh`


Usage
=====
maybe this alias is good::

    $ alias wscd='wstool_cd'

in workspace which is managed by wstool::

    $ wscd  # cd to workspace's root
    $ wscd repo0  # cd to a repo0

you can set ``WSTOOL_DEFAULT_WORKSPACE`` to cd from anywhere::

    $ export WSTOOL_DEFAULT_WORKSPACE=$HOME/ros/indigo/src
    $ pwd  # not in workspace
    /home/wkentaro
    $ wscd ros_comm && pwd # if actually not in workspace, cd to default workspace
    /home/wkentaro/ros/indigo/src/ros_comm


Screencast
==========
This is demo of using wstool_cd:

.. image:: assets/wstool_cd.gif


License
=======
| Copyright (C) 2015 Kentaro Wada
| Released under the MIT license
| https://github.com/wkentaro/wstool_cd/blob/master/LICENSE
