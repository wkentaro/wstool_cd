#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
import os
import sys
import platform
import subprocess
from setuptools import setup, find_packages


def get_data_files():

    def get_completion_install_location(shell):
        uname = platform.uname()[0]
        is_root = (os.geteuid() == 0)
        prefix = ''
        if is_root:
            # this is system install
            if uname == 'Linux':
                prefix = '/'
            elif uname == 'Darwin':
                prefix = '/usr'
        if shell == 'bash':
            location = os.path.join(prefix, 'etc/bash_completion.d')
        elif shell == 'zsh':
            location = os.path.join(prefix, 'share/zsh/site-functions')
        else:
            raise ValueError('unsupported shell: {0}'.format(shell))
        return location

    loc = dict(bash=get_completion_install_location(shell='bash'),
               zsh=get_completion_install_location(shell='zsh'))
    files = dict(bash=['completion/wstool_cd-completion.bash'],
                 zsh=['completion/wstool_cd-completion.bash',
                      'completion/_wstool_cd'])
    data_files = []
    data_files.append((loc['bash'], files['bash']))
    data_files.append((loc['zsh'], files['zsh']))
    return data_files


version = '0.9'

# publish helper
if sys.argv[-1] == 'publish':
    for cmd in [
            'python setup.py register sdist upload',
            'git tag {}'.format(version),
            'git push origin master --tag']:
        subprocess.check_call(cmd, shell=True)
    sys.exit(0)

long_desc = ('Simple command line tool to change directory'
             ' in workspace which is managed by wstool.')
setup(
    name='wstool_cd',
    version=version,
    description='Tool to change directory in workspace managed by wstool',
    long_description=long_desc,
    author='Kentaro Wada',
    author_email='www.kentaro.wada@gmail.com',
    url='http://github.com/wkentaro/wstool_cd',
    install_requires=['wstool'],
    license='MIT',
    keywords='utility',
    classifiers=[
        'Development Status :: 5 - Production/Stable',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: MIT License',
        'Operating System :: POSIX',
        'Topic :: Internet :: WWW/HTTP',
        ],
    scripts=['wstool_cd.sh', 'wstool_cd_wrapper.sh'],
    data_files=get_data_files(),
    )
