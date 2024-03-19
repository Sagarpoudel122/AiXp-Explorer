String xml = """  
     <menu id="file" value="File">  
            <popup>  
                      <menuitem value="New" onclick="CreateDoc()" />  
                      <menuitem value="Open" onclick="OpenDoc()" />  
                      <menuitem value="Save" onclick="SaveDoc()" />  
            </popup>  
      </menu>  

      <menu id="file" value="File">  
            <popup>  
                      <menuitem value="New" onclick="CreateDoc()" />  
                      <menuitem value="Open" onclick="OpenDoc()" />  
                      <menuitem value="Save" onclick="SaveDoc()" />  
            </popup>  
      </menu>  

      <menu id="file" value="File">  
            <popup>  
                      <menuitem value="New" onclick="CreateDoc()" />  
                      <menuitem value="Open" onclick="OpenDoc()" />  
                      <menuitem value="Save" onclick="SaveDoc()" />  
            </popup>  
      </menu>  
    """;

String jsonString = """
{
 "EE_ID": "XXXXXXXXXX",
  "SECURED": false,
  "IO_FORMATTER": "cavi2",
  "MAIN_LOOP_RESOLUTION": 5,
  "COMPRESS_HEARTBEAT": true,
  "MIN_AVAIL_MEM_THR": 0.25,
  "CRITICAL_RESTART_LOW_MEM": 0.20,
  "SECONDS_HEARTBEAT": 15,
  "HEARTBEAT_TIMERS": false,
  "HEARTBEAT_LOG": false,
  "PLUGINS":{
     "PLUGINS_ON_THREADS": true,
   "PLUGINS_ON_THREADS1": false,
   "Plugins": {
      "PLUGINS_ON_THREADS": true,
      "PLUGINS_ON_THREADS1": false
   }
  }
}
""";
