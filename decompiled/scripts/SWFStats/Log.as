package SWFStats
{
   import flash.events.TimerEvent;
   import flash.external.ExternalInterface;
   import flash.net.SharedObject;
   import flash.system.Security;
   import flash.utils.Timer;
   
   public final class Log
   {
      
      public static var SourceUrl:String;
      
      public static var Enabled:Boolean = false;
      
      public static var Queue:Boolean = true;
      
      public static var SWFID:int = 0;
      
      public static var GUID:String = "";
      
      private static var Request:LogRequest = new LogRequest();
      
      private static const PingF:Timer = new Timer(60000);
      
      private static const PingR:Timer = new Timer(30000);
      
      private static var FirstPing:Boolean = true;
      
      private static var Pings:int = 0;
      
      private static var Plays:int = 0;
      
      private static var HighestGoal:int = 0;
      
      public function Log()
      {
         super();
      }
      
      private static function SaveCookie(param1:String, param2:int) : void
      {
         var _loc3_:SharedObject = SharedObject.getLocal("swfstats");
         _loc3_.data[param1] = param2.toString();
         _loc3_.flush();
      }
      
      public static function View(param1:int = 0, param2:String = "", param3:String = "") : void
      {
         if(SWFID > 0)
         {
            return;
         }
         SWFID = param1;
         GUID = param2;
         Enabled = true;
         if(SWFID == 0 || GUID == "")
         {
            Enabled = false;
            return;
         }
         if(param3.indexOf("http://") != 0 && Security.sandboxType != "localWithNetwork" && Security.sandboxType != "localTrusted")
         {
            Enabled = false;
            return;
         }
         SourceUrl = GetUrl(param3);
         if(SourceUrl == null || SourceUrl == "")
         {
            Enabled = false;
            return;
         }
         Security.allowDomain("http://tracker.swfstats.com/");
         Security.allowInsecureDomain("http://tracker.swfstats.com/");
         Security.loadPolicyFile("http://tracker.swfstats.com/crossdomain.xml");
         Security.allowDomain("http://utils.swfstats.com/");
         Security.allowInsecureDomain("http://utils.swfstats.com/");
         Security.loadPolicyFile("http://utils.swfstats.com/crossdomain.xml");
         var _loc4_:* = GetCookie("views");
         _loc4_ = _loc4_ + 1;
         SaveCookie("views",_loc4_);
         Send("v/" + _loc4_,true);
         PingF.addEventListener(TimerEvent.TIMER,PingServer);
         PingF.start();
      }
      
      public static function LevelCounterMetric(param1:String, param2:*) : void
      {
         if(!Enabled)
         {
            return;
         }
         Send("lc/" + Clean(param1) + "/" + Clean(param2));
      }
      
      private static function Clean(param1:String) : String
      {
         return escape(param1.replace("/","\\").replace("~","-"));
      }
      
      public static function Play() : void
      {
         if(!Enabled)
         {
            return;
         }
         ++Plays;
         Send("p/" + Plays);
      }
      
      private static function Send(param1:String, param2:Boolean = false) : void
      {
         Request.Queue(param1);
         if(Request.Ready || param2 || !Queue)
         {
            Request.Send();
            Request = new LogRequest();
         }
      }
      
      private static function GetUrl(param1:String) : String
      {
         var url:String = null;
         var defaulturl:String = param1;
         if(ExternalInterface.available)
         {
            try
            {
               url = String(ExternalInterface.call("window.location.href.toString"));
            }
            catch(s:Error)
            {
               url = defaulturl;
            }
         }
         else if(defaulturl.indexOf("http://") == 0)
         {
            url = defaulturl;
         }
         if(url == null || url == "" || url == "null")
         {
            if(Security.sandboxType == "localWithNetwork" || Security.sandboxType == "localTrusted")
            {
               url = "http://local-testing/";
            }
            else
            {
               url = null;
            }
         }
         return escape(url);
      }
      
      public static function LevelRangedMetric(param1:String, param2:*, param3:int) : void
      {
         if(!Enabled)
         {
            return;
         }
         Send("lr/" + Clean(param1) + "/" + Clean(param2) + "/" + param3);
      }
      
      private static function GetCookie(param1:String) : int
      {
         var _loc2_:SharedObject = SharedObject.getLocal("swfstats");
         if(_loc2_.data[param1] == undefined)
         {
            return 0;
         }
         return int(_loc2_.data[param1]);
      }
      
      public static function Goal(param1:int, param2:String) : void
      {
      }
      
      private static function PingServer(... rest) : void
      {
         if(!Enabled)
         {
            return;
         }
         ++Pings;
         Send("t/" + (FirstPing ? "y" : "n") + "/" + Pings,true);
         if(FirstPing)
         {
            PingF.stop();
            PingR.addEventListener(TimerEvent.TIMER,PingServer);
            PingR.start();
            FirstPing = false;
         }
      }
      
      public static function LevelAverageMetric(param1:String, param2:*, param3:int) : void
      {
         if(!Enabled)
         {
            return;
         }
         Send("la/" + Clean(param1) + "/" + Clean(param2) + "/" + param3);
      }
      
      public static function CustomMetric(param1:String, param2:String = null) : void
      {
         if(!Enabled)
         {
            return;
         }
         if(param2 == null)
         {
            param2 = "";
         }
         Send("c/" + Clean(param1) + "/" + Clean(param2));
      }
   }
}

