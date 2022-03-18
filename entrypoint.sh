#!/bin/sh

FRONTEND_DIR=/home/ui
APP_DIR=$FRONTEND_DIR/$VERSION

mkdir -p $FRONTEND_DIR

cd $FRONTEND_DIR

if [ ! -d $VERSION/dist ] 
then
   mkdir $VERSION

   echo "Descargando version desde http://$USUARIO:*****@$URL_MOBILE_UI_REPOS/bbjet-mobile-ui-$VERSION.zip"
   cd $VERSION

   curl http://$USUARIO:$PASSWORD@$URL_MOBILE_UI_REPOS/bbjet-mobile-ui-$VERSION.zip --output bbjet-mobile-ui-$VERSION.zip
   unzip bbjet-mobile-ui-$VERSION.zip

   rm bbjet-mobile-ui-$VERSION.zip

   echo "Instalando dependencias NPM..."
   npm i
fi

cd $APP_DIR 

if [ ! -d $FRONTEND_DIR/config ]; then
   echo "No se encontro la carpeta de configuracion.  Se creara..."
   mkdir -p $FRONTEND_DIR/config/webserver
   mkdir -p $FRONTEND_DIR/config/dist
   mkdir -p $FRONTEND_DIR/config/images
   cp $APP_DIR/webserver/config_default.json $FRONTEND_DIR/config/webserver/config.json
   cp $APP_DIR/dist/properties.js $FRONTEND_DIR/config/dist/properties.js
   cp -R $APP_DIR/dist/images/* $FRONTEND_DIR/config/images
   node /config_properties.js $FRONTEND_DIR/config/dist/properties.js $REST_URL $GOOGLE_API_KEY $SYNC_PALJET
fi

echo "Modificando enlaces simbolicos"
if [ -f $APP_DIR/webserver/config.json ]; then
   rm $APP_DIR/webserver/config.json
fi 
ln -s $FRONTEND_DIR/config/webserver/config.json $APP_DIR/webserver/config.json
rm $APP_DIR/dist/properties.js
ln -s $FRONTEND_DIR/config/dist/properties.js $APP_DIR/dist/properties.js
rm -Rf $APP_DIR/images
ln -s $FRONTEND_DIR/config/images $APP_DIR/dist/images

node $APP_DIR/webserver/main.js --root $APP_DIR/dist --port 80
