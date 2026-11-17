package com.whatthefawk.ai.FSM
{
   public class NothingState extends AState
   {
      
      private static var m_instance:NothingState;
      
      public function NothingState(param1:SingletonEnforcer)
      {
         super();
      }
      
      public static function get instance() : NothingState
      {
         if(NothingState.m_instance == null)
         {
            NothingState.m_instance = new NothingState(new SingletonEnforcer());
         }
         return NothingState.m_instance;
      }
   }
}

class SingletonEnforcer
{
   
   public function SingletonEnforcer()
   {
      super();
   }
}
