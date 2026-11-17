package com.whatthefawk.ai.steering.path
{
   import flash.utils.Dictionary;
   
   public class PathFactory
   {
      
      private var m_pathParams:Dictionary;
      
      public function PathFactory()
      {
         super();
         this.m_pathParams = new Dictionary();
      }
      
      public function registerPath(param1:PathParams) : *
      {
         this.m_pathParams[param1.id] = param1;
      }
      
      public function getPath(param1:String) : Path
      {
         var _loc2_:PathParams = this.m_pathParams[param1];
         return new Path(_loc2_);
      }
   }
}

