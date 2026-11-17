package SWFStats
{
   import flash.events.HTTPStatusEvent;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   
   public final class LogRequest
   {
      
      private static var Failed:int = 0;
      
      private var Data:String = "";
      
      public var Ready:Boolean = false;
      
      private var Pieces:int;
      
      public function LogRequest()
      {
         super();
      }
      
      private function IOErrorHandler(param1:IOErrorEvent) : void
      {
         ++Failed;
      }
      
      public function Queue(param1:String) : void
      {
         if(Failed > 3)
         {
            return;
         }
         ++this.Pieces;
         this.Data += (this.Data == "" ? "" : "~") + param1;
         if(this.Pieces == 8 || this.Data.length > 300)
         {
            this.Ready = true;
         }
      }
      
      private function SecurityErrorHandler(param1:SecurityErrorEvent) : void
      {
      }
      
      private function StatusChange(param1:HTTPStatusEvent) : void
      {
      }
      
      public function Send() : void
      {
         var _loc1_:URLLoader = new URLLoader();
         _loc1_.addEventListener(IOErrorEvent.IO_ERROR,this.IOErrorHandler);
         _loc1_.addEventListener(HTTPStatusEvent.HTTP_STATUS,this.StatusChange);
         _loc1_.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.SecurityErrorHandler);
         _loc1_.load(new URLRequest("http://tracker.swfstats.com/Games/q.aspx?guid=" + Log.GUID + "&swfid=" + Log.SWFID + "&q=" + this.Data + "&url=" + Log.SourceUrl + "&" + Math.random() + "z"));
      }
   }
}

