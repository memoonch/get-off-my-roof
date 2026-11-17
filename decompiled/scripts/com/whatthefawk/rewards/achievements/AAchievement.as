package com.whatthefawk.rewards.achievements
{
   public class AAchievement implements IAchievement
   {
      
      protected var _isComplete:Boolean;
      
      protected var _name:String;
      
      protected var _id:String;
      
      protected var _description:String;
      
      public function AAchievement()
      {
         super();
         this._isComplete = false;
      }
      
      public function get isComplete() : Boolean
      {
         return this._isComplete;
      }
      
      public function forceComplete() : void
      {
         this._isComplete = true;
      }
      
      public function check() : Boolean
      {
         throw new Error("<AAchievement::check> Abstract function check() must be overridden.");
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function get description() : String
      {
         return this._description;
      }
   }
}

