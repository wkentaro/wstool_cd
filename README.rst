=========
wstool_cd
=========
``cd`` to repositories in workspace which is managed by `vcstools/wstool <https://github.com/vcstools/wstool>`_.


Installation
============


for antigen users
-----------------
add following to your `.zshrc`::

    antigen bundle wkentaro/wstool_cd


for others
----------
download the repository to your local space::

    $ git clone https://github.com/wkentaro/wstool_cd.git ~/.wstool_cd

add following to your `.bashrc` or `.zshrc`::

    source ~/.wstool_cd/wstool_cd.sh
    source ~/.wstool_cd/wstool_cd-completion.bash


Usage
=====
in workspace which is managed by wstool::

    # change dir to repository_name
    $ wstool_cd repository_name
    # change dir to workspace's root
    $ wstool_cd


Screencast
==========
This is demo of using wstool_cd:

.. image:: assets/wstool_cd.gif


License
=======
| Copyright (C) 2015 Kentaro Wada
| Released under the MIT license
| https://github.com/wkentaro/wstool_cd/blob/master/LICENSE