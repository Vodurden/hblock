module Arkmonoid.Physics.CollisionDetection.GameCollision where

import           Control.Lens ((^.))
import           Data.Set (Set)
import qualified Data.Set as Set

import Arkmonoid.Physics.Types
import Arkmonoid.Physics.CollisionDetection.Types

idPair :: GameCollision id -> [(id, id)]
idPair (GBoundaryCollision _ _) = []
idPair (GExistingCollision _ cs) = fmap (\e -> (e^.objectId, e^.targetId)) cs
idPair (GImpendingCollision _ impending) = [(impending^.objectId, impending^.targetId)]

-- | Returns all the physical objects involved in this collision
objects :: GameCollision id -> [PhysicalObject]
objects (GBoundaryCollision _ collisions) = fmap (\c -> c^.boundaryCollision.object) collisions
objects (GExistingCollision _ collisions) =
  concatMap (\c -> [c^.existingCollision.object, c^.existingCollision.target]) collisions
objects (GImpendingCollision _ collision) =
  [collision^.impendingCollision.object, collision^.impendingCollision.target]

materials :: GameCollision id -> Set Material
materials collision = Set.fromList $ (^.material) <$> objects collision

-- | Returns true if the collision contains all of the given materials
hasMaterial :: GameCollision id -> Material -> Bool
hasMaterial collisions mat = Set.member mat (materials collisions)
