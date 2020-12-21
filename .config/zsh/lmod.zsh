unset  _mlshdbg;
# disable shell debugging for the run of this init file
if [ "${MODULES_SILENT_SHELL_DEBUG:-0}" = '1' ]; then
   # immediately disable debugging to echo the less number of line possible
   case "$-" in
      *v*x*) set +vx; _mlshdbg='vx' ;;
      *v*) set +v; _mlshdbg='v' ;;
      *x*) set +x; _mlshdbg='x' ;;
      *) _mlshdbg='' ;;
   esac;
fi;

# define modules runtine quarantine configuration
#export MODULES_RUN_QUARANTINE='ENVVARNAME'

# setup quarantine if defined
unset _mlre _mlIFS;
if [ -n "${IFS+x}" ]; then
   _mlIFS=$IFS;
fi;
IFS=' ';
for _mlv in ${=MODULES_RUN_QUARANTINE:-}; do
   if [ "${_mlv}" = "${_mlv##*[!A-Za-z0-9_]}" -a "${_mlv}" = "${_mlv#[0-9]}" ]; then
      if [ -n "`eval 'echo ${'$_mlv'+x}'`" ]; then
         _mlre="${_mlre:-}${_mlv}_modquar='`eval 'echo ${'$_mlv'}'`' ";
      fi;
      _mlrv="MODULES_RUNENV_${_mlv}";
      _mlre="${_mlre:-}${_mlv}='`eval 'echo ${'$_mlrv':-}'`' ";
   fi;
done;
if [ -n "${_mlre:-}" ]; then
   _mlre="eval ${_mlre}";
fi;

# define module command and surrounding initial environment (default value
# for MODULESHOME, MODULEPATH, LOADEDMODULES and parse of init config files)
_mlcode=`${=_mlre:-}/app/vbuild/sys/tcl/0/bin/tclsh /app/vbuild/tools/modulestcl/4.5.2/libexec/modulecmd.tcl zsh autoinit`
_mlret=$?

# clean temp variables used to setup quarantine
if [ -n "${_mlIFS+x}" ]; then
   IFS=$_mlIFS;
   unset _mlIFS;
else
   unset IFS;
fi;
unset _mlre _mlv _mlrv

# no environment alteration if the above autoinit command failed
if [ $_mlret -eq 0 ]; then
   eval "$_mlcode"

   # redefine module command if compat version has been activated
   if [ "${MODULES_USE_COMPAT_VERSION:-0}" = '1' ]; then
      MODULES_CMD=/app/vbuild/tools/modulestcl/4.5.2/libexec/modulecmd-compat
      export MODULES_CMD
      if [ -t 2 ]; then
         _module_raw() { eval `/app/vbuild/tools/modulestcl/4.5.2/libexec/modulecmd-compat zsh $*`; }
      else
         module() { eval `/app/vbuild/tools/modulestcl/4.5.2/libexec/modulecmd-compat zsh $*`; }
      fi
   fi

   # define function to switch between C and Tcl versions of Modules
   switchml() {
      typeset swfound=1
      if [ "${MODULES_USE_COMPAT_VERSION:-0}" = '1' ]; then
         typeset swname='main'
         if [ -e /app/vbuild/tools/modulestcl/4.5.2/libexec/modulecmd.tcl ]; then
            typeset swfound=0
            unset MODULES_USE_COMPAT_VERSION
         fi
      else
         typeset swname='compatibility'
         if [ -e /app/vbuild/tools/modulestcl/4.5.2/libexec/modulecmd-compat ]; then
            typeset swfound=0
            MODULES_USE_COMPAT_VERSION=1
            export MODULES_USE_COMPAT_VERSION
         fi
      fi

      # switch version only if command found
      if [ $swfound -eq 0 ]; then
         echo "Switching to Modules $swname version"
         source /app/vbuild/tools/modulestcl/4.5.2/init/zsh
      else
         echo "Cannot switch to Modules $swname version, command not found"
         return 1
      fi
   }

   if [ "$MODULES_USE_COMPAT_VERSION" != '1' ]; then
   # setup FPATH to put module completion at hand in case zsh completion enabled
   if [[ ! ":$FPATH:" =~ ':/app/vbuild/tools/modulestcl/4.5.2/init/zsh-functions:' ]]; then
      FPATH=/app/vbuild/tools/modulestcl/4.5.2/init/zsh-functions${FPATH:+:}$FPATH
      export FPATH
   fi
   # no completion support on compat version
   elif typeset -f compdef >/dev/null; then
      compdef -d module
   fi

   if [[ ! ":$PATH:" =~ ':/app/vbuild/tools/modulestcl/4.5.2/bin:' ]]; then
      PATH=/app/vbuild/tools/modulestcl/4.5.2/bin${PATH:+:}$PATH
      export PATH
   fi

   # initialize MANPATH if empty (zsh defines MANPATH empty by default) with a
   # value that preserves manpath system configuration even after addition of
   # paths to this variable by modulefiles
   if [ ! -n "${MANPATH:+x}" ]; then
      MANPATH=:
      export MANPATH
   fi
   if [[ ! ":`manpath 2>/dev/null`:" =~ ':/app/vbuild/tools/modulestcl/4.5.2/share/man:' ]]; then
      if [ "$MANPATH" = ':' ] || [ "$MANPATH" = '' ]; then
         _mlpathsep=''
      else
         _mlpathsep=:
      fi
      MANPATH=/app/vbuild/tools/modulestcl/4.5.2/share/man$_mlpathsep$MANPATH
      export MANPATH
      unset _mlpathsep
   fi
fi

unset _mlcode _mlret

# restore shell debugging options if disabled
if [ -n "${_mlshdbg:-}" ]; then
   set -$_mlshdbg;
   unset _mlshdbg;
fi;
