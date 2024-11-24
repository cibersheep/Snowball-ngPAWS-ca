mkdir build
cp -u ../Release-linux-es/plugins/draw_picture_svg_lib/draw_picture_svg.jsp jsl/

../Release-linux-es/txtpaws -I./dat/ code.txp

../Release-linux-es/ngpc code.sce

cp -u ../Release-linux-es/{index.html,css.css,buzz.js,jquery.js} build/ 

cp -R dat build/

cp -u code.js build/

browse build/index.html
