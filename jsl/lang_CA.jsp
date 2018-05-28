//LIB lang_CA

//-----------------------------------------------------------
//  Aquesta funció personalitza les sequències d'escapament 
//  {OREF} i {OBJECT} per fer-les servir en català.
//----------------------------------------------------------

// Aux functions
function getApostrophe(objno)
{
	var ATTR_APOSTROPHE = 22;
	var mustApostropheWord = objectIsAttr(objno, ATTR_APOSTROPHE);
	return mustApostropheWord;
}

function getObjectFixArticles_lang_CA(objno)
{
	var object_text = getObjectText(objno);
	var object_words = object_text.split(' ');
	if (object_words.length == 1) return object_text;
	var candidate = object_words[0];
	object_words.splice(0, 1);
	if ( (candidate!='un') && (candidate!='una') && (candidate!='uns') && (candidate!='unes') && (candidate!='algun') && (candidate!='algunes') ) return object_text;
	var gender = getAdvancedGender(objno);
	var shouldApostrophe = getApostrophe(objno);
	if ((gender == 'F' || gender == 'M' || gender == 'N') && shouldApostrophe) return "l'" + object_words.join(' ');
	if (gender == 'F') return 'la ' + object_words.join(' ');
	if (gender == 'M') return 'el ' + object_words.join(' ');
	if (gender == 'N') return 'el ' + object_words.join(' ');
	if (gender == 'PF') return 'les ' + object_words.join(' ');
	if (gender == 'PM') return 'els ' + object_words.join(' ');
	if (gender == 'PN') return 'els ' + object_words.join(' ');
}


// Sequence tag replacement

var old_writeHook_lang_CA = h_sequencetag;
var h_sequencetag = function (tagparams)
{
	var tag = tagparams[0].toUpperCase();
	switch (tag)
	{
	case 'OREF':
		if (tagparams.length != 1) {return '[[[' + STR_INVALID_TAG_SEQUENCE_BADPARAMS + ']]]'};
   		if(objects[getFlag(FLAG_REFERRED_OBJECT)]) return getObjectFixArticles_lang_CA(getFlag(FLAG_REFERRED_OBJECT)); else return '';
   		break;
	case 'OBJECT':
		if (tagparams.length != 2) {return '[[[' + STR_INVALID_TAG_SEQUENCE_BADPARAMS + ']]]'};
		if(objects[getFlag(tagparams[1])]) return getObjectFixArticles_lang_CA(getFlag(tagparams[1])); else return '';
		break;
	default:
		return old_writeHook_lang_CA(tagparams);
	}
}


// Personalized normalize function adapted for Catalan language

normalize = function(player_order)
	// Removes accented characters and makes sure every sentence separator (colon, semicolon, quotes, etc.) has one space before and after. Also, all separators are converted to comma
{
	player_order = player_order.replace(/l'/gi, "").replace(/'l/gi, "-ho").replace(/d'/gi, "de ").replace(/'n/gi, " en").replace(/'t/gi, "te")
	var originalchars = 'áéíóúäëïöüâêîôûàèìòùÁÉÍÓÚÄËÏÖÜÂÊÎÔÛÀÈÌÒÙ';
	var i;
	var output = '';
	var pos;

	for (i=0;i<player_order.length;i++) 
	{
		pos = originalchars.indexOf(player_order.charAt(i));
		if (pos!=-1) output = output + "aeiou".charAt(pos % 5); else 
		{
			ch = player_order.charAt(i);
				if ((ch=='.') || (ch==',') || (ch==';') || (ch=='"') || (ch=='\'') || (ch=='«') || (ch=='</span>')) output = output + ' , '; else output = output + player_order.charAt(i);
		}

	}
	return output;
}
	

//CND HELP A 0 0 0 0
//Catalan help responses

function ACChelp()
{
	writeText('<b>• Com dono ordres al joc?</b>');
	writeText(STR_NEWLINE);
	writeText('Utilitzeu ordres en imperatiu o infinitiu: <span class="feedback">OBRE PORTA</span>, <span class="feedback">AGAFAR CLAU</span>, <span class="feedback">PUJAR</span>, etc.');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('<b>• Com em puc moure pel joc?</b>');
	writeText(STR_NEWLINE);
	writeText('Generalment, mitjançant els punts cardinals com <span class="feedback">NORD</span> (abreujat <span class="feedback">N</span>), <span class="feedback">SUD</span> (<span class="feedback">S</span>), <span class="feedback">EST</span> (<span class="feedback">E</span>), <span class="feedback">OEST</span> (<span class="feedback">O</span>) o amb direccions espacials (<span class="feedback">AMUNT</span>, <span class="feedback">AVALL</span>, <span class="feedback">BAIXAR</span>, <span class="feedback">PUJAR</span>, <span class="feedback">ENTRAR</span>, <span class="feedback">SORTIR</span>, etc.). Normalment sabreu cap a quina direcció podreu anar per la descripció que rebreu. Escriviu <span class="feedback">SORTIDES</span> per a que us mostri exactament de quines disposau.');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('<b>• Com puc saber quins objectes duc?</b>');
	writeText(STR_NEWLINE);
	writeText('Teclegeu <span class="feedback">INVENTARI</span> (abreujat <span class="feedback">IN</span>)');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('<b>• Com uso els objectes?</b>');
	writeText(STR_NEWLINE);
	writeText('Utilizeu un verb el més concret que pogueu, en lloc de <span class="feedback">USAR ESCOMBRA</span> escriviu <span class="feedback">ESCOMBRAR</span>.');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('<b>• Com puc mirar de prop un objecte o observar-lo més detalladament?</b>');
	writeText(STR_NEWLINE);
	writeText('Amb el verb <span class="feedback">EXAMINAR</span>: <span class="feedback">EXAMINAR PLAT</span>. Es pot usar l\'abreviatura <span class="feedback">EX</span>: <span class="feedback">EX PLAT</span>.');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('<b>• Com puc tornar a veure la descripció del lloc on sóc?</b>');
	writeText(STR_NEWLINE);
	writeText('Escriviu <span class="feedback">MIRAR</span> (abreujat <span class="feedback">M</span>).');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('<b>• Com poso quelcom dins un contenidor? Com ho trec?</b>');
	writeText(STR_NEWLINE);
	writeText('<span class="feedback">FICAR CLAU DINS CAIXA</span>. <span class="feedback">TREU CLAU DE CAIXA</span>');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('<b>• Com poso quelcom a sobre una altra cosa? Com ho trec?</b>');
	writeText(STR_NEWLINE);
	writeText('<span class="feedback">POSAR CLAU DAMUNT TAULA</span>. <span class="feedback">AGAFAR CLAU DE TAULA</span>');
	writeText(STR_NEWLINE + STR_NEWLINE);
	writeText('<b>• Com deso i carrego la partida?</b>');
	writeText(STR_NEWLINE);
	writeText('Usa les ordres <span class="feedback">DESAR</span> i <span class="feedback">CARREGAR</span>.');
	writeText(STR_NEWLINE + STR_NEWLINE);
}

function ACCinven()
{
	var count = 0;
	writeSysMessage(SYSMESS_YOUARECARRYING);
	ACCnewline();
	var listnpcs_with_objects = !bittest(getFlag(FLAG_PARSER_SETTINGS),3);
	var i;
	for (i=0;i<num_objects;i++)
	{
		if ((getObjectLocation(i)) == LOCATION_CARRIED)
		{
			
			if ((listnpcs_with_objects) || (!objectIsNPC(i)))
			{
				writeObject(i);
				if ((objectIsAttr(i,ATTR_SUPPORTER))  || (  (objectIsAttr(i,ATTR_TRANSPARENT))  && (objectIsAttr(i,ATTR_CONTAINER))))  ACClistat(i, i);
				ACCnewline();
				count++;
			}
		}
		if (getObjectLocation(i) == LOCATION_WORN)
		{
			if (listnpcs_with_objects || (!objectIsNPC(i)))
			{
				writeObject(i);
				if (objectIsAttr(i,ATTR_FEMALE)) 
				{
					writeText(' (posada)') 
				} else 	writeText(' (posat)');
				count++;
				ACCnewline();
			}
		}
	}
	if (!count) 
	{
		 writeSysMessage(SYSMESS_CARRYING_NOTHING);
		 ACCnewline();
	}

	if (!listnpcs_with_objects)
	{
		var numNPC = getNPCCountAt(LOCATION_CARRIED);
		if (numNPC)	ACClistnpc(LOCATION_CARRIED);
	}
	done_flag = true;
}
