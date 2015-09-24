#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
import os
import sys
import platform
import subprocess
from setuptools import setup, find_packages

from distutils.core import Command


def _resolve_prefix(prefix, type):
    osx_system_prefix = '/System/Library/Frameworks/Python.framework/Versions'
    if type == 'man':
        if prefix == '/usr':
            return '/usr/share'
        if sys.prefix.startswith(osx_system_prefix):
            return '/usr/share'
    elif type == 'bash_comp':
        if prefix == '/usr':
            return '/'
        if sys.prefix.startswith(osx_system_prefix):
            return '/'
    elif type == 'zsh_comp':
        if sys.prefix.startswith(osx_system_prefix):
            return '/usr'
    else:
        raise ValueError('not supported type')
    return prefix


def get_data_files():
    data_files = []
    bash_comp_dest = _resolve_prefix('', type='bash_comp')
    data_files.append((bash_comp_dest, ['completion/wstool_cd-completion.bash']))
    zsh_comp_dest = _resolve_prefix('', type='zsh_comp')
    data_files.append((zsh_comp_dest, ['completion/wstool_cd-completion.bash',
                                       'completion/_wstool_cd']))
    return data_files


version = '0.15'

class WstoolCdPublish(Command):
    description = 'Publish helper'
    user_options = []
    def initialize_options(self): pass
    def finalize_options(self): pass
    def run(self):
        self.run_command('register')
        self.run_command('sdist')
        self.run_command('upload')
        subprocess.call(['git', 'tag', version])
        subprocess.call(['git', 'push', 'origin', 'master', '--tag'])

cmdclass = {'publish': WstoolCdPublish}

setup(
    name='wstool_cd',
    version=version,
    description='Tool to change directory in workspace managed by wstool',
    long_description=open('README.rst').read(),
    author='Kentaro Wada',
    author_email='www.kentaro.wada@gmail.com',
    url='http://github.com/wkentaro/wstool_cd',
    install_requires=open('requirements.txt').readlines(),
    cmdclass=cmdclass,
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
