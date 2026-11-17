package com.whatthefawk.weapons.melee
{
   import com.whatthefawk.GameFactory;
   import flash.utils.Dictionary;
   
   public class MeleeWeaponFactory
   {
      
      private var m_paramMap:Dictionary;
      
      private var m_gameFactory:GameFactory;
      
      public function MeleeWeaponFactory(param1:GameFactory)
      {
         super();
         this.m_gameFactory = param1;
         this.m_paramMap = new Dictionary();
      }
      
      public function getWeapon(param1:String, param2:*) : MeleeWeapon
      {
         var _loc3_:MeleeWeapon = this.m_gameFactory.getEntity(param1);
         _loc3_.setAgent(param2);
         _loc3_.applyAbility();
         return _loc3_;
      }
      
      public function registerWeapon(param1:MeleeWeaponParams) : void
      {
         this.m_paramMap[param1.type] = param1;
         this.m_gameFactory.registerEntity(param1);
      }
   }
}

