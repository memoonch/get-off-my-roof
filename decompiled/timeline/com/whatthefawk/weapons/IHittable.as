package com.whatthefawk.weapons
{
   import com.whatthefawk.life.stats.StatEffect;
   
   public interface IHittable
   {
      
      function get onHitStatEffect() : StatEffect;
   }
}

