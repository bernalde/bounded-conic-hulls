module

public import Chapter08HullCompact

/-! The boxed finite conic-union continuous hull and compact lift. Finite bounds, explicit dependent residual dimensions and cone hypotheses are retained. Empty branches/index sets are allowed; this is not a general whole-GDP ideality theorem. -/
@[expose] public section
noncomputable section
open scoped BigOperators
open Set

namespace PalomarConicHull
open Chapter08.ContinuousHull
variable {ι : Type*} [Fintype ι] {n : ℕ}

theorem exact_hull (D : Data ι n) (hD : Conic D) :
    projection D = convexHull ℝ (boundedUnion D) := by
  exact Chapter08.ContinuousHull.continuous_hull_exact D hD

theorem compact_lift (D : Data ι n) (hK : ∀ i, IsClosed (D.cone i)) :
    IsCompact (fullLift D) := by
  exact Chapter08.ContinuousHull.isCompact_fullLift D hK

theorem closed_hull (D : Data ι n) (hD : Conic D)
    (hK : ∀ i, IsClosed (D.cone i)) :
    closure (convexHull ℝ (boundedUnion D)) = projection D := by
  exact Chapter08.ContinuousHull.closed_hull_exact D hD hK

end PalomarConicHull
