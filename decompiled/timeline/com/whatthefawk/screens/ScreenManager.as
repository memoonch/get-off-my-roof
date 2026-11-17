package com.whatthefawk.screens
{
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   
   public class ScreenManager
   {
      
      private var m_currentGroupID:String;
      
      private var m_screenGroups:Dictionary;
      
      private var m_root:IScreenItem;
      
      private var m_screens:Dictionary;
      
      private var m_currentGroupIndex:int;
      
      public function ScreenManager(param1:IScreenItem = null)
      {
         super();
         this.m_root = param1;
         this.m_screens = new Dictionary();
         this.m_screenGroups = new Dictionary();
         this.m_currentGroupID = "";
         this.m_currentGroupIndex = 0;
      }
      
      public function addChildScreen(param1:String, param2:IScreenItem) : void
      {
         if(this.m_screens[param1] == null)
         {
            throw new Error("<ScreenManager> Screen " + param1 + " does not exist.");
         }
         param2.addChildScreen(param1,this.m_screens[param1]);
      }
      
      public function getScreen(param1:String) : IScreenItem
      {
         if(this.m_screens[param1] == null)
         {
            throw new Error("<ScreenManager> Screen " + param1 + " does not exist.");
         }
         return new this.m_screens[param1]();
      }
      
      public function removeChildScreen(param1:String, param2:IScreenItem) : void
      {
         if(this.m_screens[param1] == null)
         {
            throw new Error("<ScreenManager> Screen " + param1 + " does not exist.");
         }
         param2.removeChildScreen(param1);
      }
      
      public function setScreen(param1:String, param2:IScreenItem = null) : void
      {
         if(this.m_screens[param1] == null)
         {
            throw new Error("<ScreenManager> Screen " + param1 + " does not exist.");
         }
         var _loc3_:Class = this.m_screens[param1];
         if(param2)
         {
            this.m_root.setScreen(_loc3_);
         }
         else
         {
            this.m_root.setScreen(_loc3_);
         }
      }
      
      public function registerScreen(param1:String, param2:Class, param3:String = null) : void
      {
         if(this.m_screens[param1] != null)
         {
            throw new Error("<ScreenManager> Screen " + param1 + " has already been registered.");
         }
         this.m_screens[param1] = param2;
         if(param3 != null)
         {
            if(this.m_screenGroups[param3] == null)
            {
               this.m_screenGroups[param3] = [];
            }
            this.m_screenGroups[param3].push(param1);
         }
      }
      
      public function getScreenClass(param1:String) : Class
      {
         if(this.m_screens[param1] == null)
         {
            throw new Error("<ScreenManager> Screen " + param1 + " does not exist.");
         }
         return this.m_screens[param1];
      }
      
      public function prevScreen() : void
      {
      }
      
      public function setGroupIndex(param1:int = 0) : void
      {
         if(!this.m_currentGroupID)
         {
            return;
         }
         this.setGroup(this.m_currentGroupID,param1);
      }
      
      public function setGroup(param1:String, param2:int = 0, param3:IScreenItem = null) : void
      {
         if(!this.m_screenGroups[param1])
         {
            return;
         }
         this.m_currentGroupID = param1;
         this.setScreen(this.m_screenGroups[param1][param2],param3);
      }
      
      public function nextScreen() : void
      {
      }
   }
}

