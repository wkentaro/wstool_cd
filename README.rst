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
in workspace which is managed by wstool::

    # change dir to repository_name
    $ wstool_cd repository_name
    # change dir to workspace's root
    $ wstool_cd

maybe this alias is good::

    $ alias wscd='wstool_cd'


Screencast
==========
This is demo of using wstool_cd:

.. image:: assets/wstool_cd.gif


License
=======
| Copyright (C) 2015 Kentaro Wada
| Released under the MIT license
| https://github.com/wkentaro/wstool_cd/blob/master/LICENSE