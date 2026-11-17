package com.whatthefawk.weapons.projectile
{
   import com.whatthefawk.GameFactory;
   import com.whatthefawk.entity.Entity;
   import com.whatthefawk.entity.EntityParams;
   import flash.utils.Dictionary;
   
   public class ProjectileWeaponFactory
   {
      
      private var m_paramMap:Dictionary;
      
      private var m_gameFactory:GameFactory;
      
      public function ProjectileWeaponFactory(param1:GameFactory)
      {
         super();
         this.m_gameFactory = param1;
         this.m_paramMap = new Dictionary();
      }
      
      public function getProjectileParams(param1:String) : EntityParams
      {
         return this.m_gameFactory.getEntityParams(param1);
      }
      
      public function getWeaponParams(param1:String) : ProjectileParams
      {
         if(!this.m_paramMap[param1])
         {
            return null;
         }
         return this.m_paramMap[param1];
      }
      
      public function getWeapon(param1:String, param2:*) : ProjectileWeapon
      {
         var _loc3_:ProjectileWeaponParams = this.m_paramMap[param1];
         _loc3_.agent = param2;
         _loc3_.projectileFactory = this;
         return new _loc3_.customClass(_loc3_);
      }
      
      public function registerProjectile(param1:ProjectileParams) : void
      {
         this.m_gameFactory.registerEntity(param1);
      }
      
      public function getProjectile(param1:String, param2:Entity = null) : Projectile
      {
         return this.m_gameFactory.getEntity(param1,param2);
      }
      
      public function registerWeapon(param1:ProjectileWeaponParams) : void
      {
         this.m_paramMap[param1.id] = param1;
      }
   }
}

