package com.urbansquall.ginger.tools
{
   import com.urbansquall.ginger.AnimationPlayer;
   import flash.utils.Dictionary;
   
   public class AnimationPlayerFactory
   {
      
      private var m_animations:Dictionary;
      
      public function AnimationPlayerFactory()
      {
         super();
         this.m_animations = new Dictionary();
      }
      
      public function instantiate(param1:String) : AnimationPlayer
      {
         if(this.m_animations[param1] == null)
         {
            throw new Error("AnimationFactory:instantiate. There is no animation with the name [" + param1 + "]");
         }
         var _loc2_:AnimationPlayer = this.m_animations[param1];
         return _loc2_.copy();
      }
      
      public function register(param1:String, param2:AnimationPlayer) : void
      {
         if(this.m_animations[param1] != null)
         {
            throw new Error("AnimationFactory:register. There is already an animation with the name [" + param1 + "]");
         }
         this.m_animations[param1] = param2;
      }
      
      public function dispose() : void
      {
         var _loc1_:String = null;
         var _loc2_:AnimationPlayer = null;
         for(_loc1_ in this.m_animations)
         {
            _loc2_ = this.m_animations[_loc1_];
            delete this.m_animations[_loc1_];
         }
         this.m_animations = null;
      }
   }
}

