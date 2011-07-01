version=$1
dir=`pwd`/../release-$version

function remove_svn () {
  (
  cd $1

  if [ -d .svn ]; then
     rm -rf .svn
  fi

  for j in `ls`
  do
     if [ -d $j ]; then
        remove_svn $j
     fi
  done
  )
}

function package_all () {
   qual=$1

   zip -r $dir/buildcraft$qual-A-core-$version.zip \
      mod_BuildCraftCore*.class \
      BuildCraftCore*.class \
      RenderPassiveItem.class \
      BuildCraftBlockUtil.class \
      buildcraft/core \
      net/minecraft/src/buildcraft/core \
      buildcraft/api

   zip -r $dir/buildcraft$qual-B-transport-$version.zip \
      mod_BuildCraftTransport*.class \
      BuildCraftTransport*.class \
      buildcraft/transport \
      net/minecraft/src/buildcraft/transport \
      buildcraft/api

   zip -r $dir/buildcraft$qual-B-factory-$version.zip \
      mod_BuildCraftFactory*.class \
      BuildCraftFactory*.class \
      buildcraft/factory \
      net/minecraft/src/buildcraft/factory \
      buildcraft/api

   zip -r $dir/buildcraft$qual-B-builders-$version.zip \
      mod_BuildCraftBuilders*.class \
      BuildCraftBuilders*.class \
      buildcraft/builders \
      net/minecraft/src/buildcraft/builders \
      buildcraft/api

   zip -r $dir/buildcraft$qual-C-devel-$version.zip \
      mod_BuildCraftDevel*.class \
      buildcraft/devel \
      buildcraft/api

   zip -r $dir/buildcraft$qual-api-$version.zip \
      buildcraft/api

}

cd ../reobf

remove_svn .

rm -rf $dir
mkdir $dir

cd minecraft
package_all "-client"

cd ../minecraft_server
package_all "-server"

cd ../..

rm -rf reobf
