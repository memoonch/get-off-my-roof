package com.whatthefawk.weapons.explosion
{
   import com.whatthefawk.GameFactory;
   import flash.utils.Dictionary;
   
   public class ExplosionFactory
   {
      
      private var m_paramMap:Dictionary;
      
      private var m_gameFactory:GameFactory;
      
      public function ExplosionFactory(param1:GameFactory)
      {
         super();
         this.m_gameFactory = param1;
         this.m_paramMap = new Dictionary();
      }
      
      public function registerExplosion(param1:ExplosionParams) : void
      {
         this.m_paramMap[param1.type] = param1;
         this.m_gameFactory.registerEntity(param1);
      }
      
      public function getExplosion(param1:String) : Explosion
      {
         return this.m_gameFactory.getEntity(param1);
      }
   }
}

