//CND EXITS A 8 5 0 0

function ACCexits(locno,mesno)
{
  if ((getFlag(FLAG_LIGHT) == 0) || ((getFlag(FLAG_LIGHT) != 0) && lightObjectsPresent()))
  {
  		var exitcount = 0;
  		for (i=0;i<NUM_CONNECTION_VERBS;i++) if (getConnection(locno, i) != -1) exitcount++;
      if (exitcount)
      {
    		writeMessage(mesno);
    		var exitcountprogress = 0;
    		for (i=0;i<NUM_CONNECTION_VERBS;i++) if (getConnection(locno, i) != -1)
    		{ 
    			exitcountprogress++;
			if (getConnection(locno, i) == 0) { writeMessage(mesno + 2 + i); writeText(" (a través d'una porta)"); }
    			else writeMessage(mesno + 2 + i);
    			if (exitcountprogress == exitcount) writeSysMessage(SYSMESS_LISTEND);
    			if (exitcountprogress == exitcount-1) writeSysMessage(SYSMESS_LISTLASTSEPARATOR);
    			if (exitcountprogress <= exitcount-2) writeSysMessage(SYSMESS_LISTSEPARATOR);
  		  }
      } else writeMessage(mesno + 1);
  } else writeMessage(mesno + 1);
}
