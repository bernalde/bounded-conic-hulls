module

public import Mathlib.Algebra.Order.Floor.Ring
public import Mathlib.Analysis.Calculus.Deriv.AffineMap
public import Mathlib.Analysis.Calculus.Deriv.Comp
public import Mathlib.Analysis.Convex.Combination
public import Mathlib.Analysis.Convex.Deriv
public import Mathlib.Analysis.Normed.Module.FiniteDimension
public import Mathlib.Analysis.SpecialFunctions.Exp
public import Mathlib.Analysis.SpecialFunctions.Log.Basic
public import Mathlib.Data.Int.Interval
public import Mathlib.Data.Pi.Interval
public import Mathlib.Tactic
public import Mathlib.Tactic.FunProp
public import Mathlib.Tactic.Linarith
public import Mathlib.Tactic.NormNum
public import Mathlib.Tactic.Ring
public import Mathlib.Topology.Order.Compact

/-! The boxed finite conic-union continuous hull and compact lift. Finite bounds, explicit dependent residual dimensions and cone hypotheses are retained. Empty branches/index sets are allowed; this is not a general whole-GDP ideality theorem. -/
@[expose] public section
noncomputable section
open scoped BigOperators
open Set

namespace Chapter08
abbrev Vec (n : ℕ) := Fin n → ℝ

def InBox {n : ℕ} (lo hi x : Vec n) : Prop := ∀ j, lo j ≤ x j ∧ x j ≤ hi j

end Chapter08

namespace Chapter08.ContinuousHull
structure Data (ι : Type*) (n : ℕ) where
  dim : ι → ℕ
  map : (i : ι) → Vec n →ₗ[ℝ] Vec (dim i)
  offset : (i : ι) → Vec (dim i)
  cone : (i : ι) → Set (Vec (dim i))
  lower : Vec n
  upper : Vec n

structure Conic {ι : Type*} {n : ℕ} (D : Data ι n) : Prop where
  zero_mem : ∀ i, 0 ∈ D.cone i
  convex : ∀ i, Convex ℝ (D.cone i)
  smul_mem : ∀ i (a : ℝ), 0 ≤ a → ∀ z ∈ D.cone i, a • z ∈ D.cone i

variable {ι : Type*} [Fintype ι] {n : ℕ}

abbrev LiftPoint (ι : Type*) (n : ℕ) := (ι → ℝ) × (ι → Vec n)

def branch (D : Data ι n) (i : ι) : Set (Vec n) :=
  {x | InBox D.lower D.upper x ∧ D.map i x - D.offset i ∈ D.cone i}

def boundedUnion (D : Data ι n) : Set (Vec n) := ⋃ i, branch D i

def lift (D : Data ι n) : Set (LiftPoint ι n) :=
  {p | (∀ i, 0 ≤ p.1 i) ∧ (∑ i, p.1 i) = 1 ∧
    (∀ i, D.map i (p.2 i) - p.1 i • D.offset i ∈ D.cone i) ∧
    (∀ i j, D.lower j * p.1 i ≤ p.2 i j ∧ p.2 i j ≤ D.upper j * p.1 i)}

def projection (D : Data ι n) : Set (Vec n) :=
  {x | ∃ p ∈ lift D, x = ∑ i, p.2 i}

/-- The literal full system retains the displayed x coordinate and its equality. -/
def fullLift (D : Data ι n) : Set (Vec n × LiftPoint ι n) :=
  {p | p.2 ∈ lift D ∧ p.1 = ∑ i, p.2.2 i}

end Chapter08.ContinuousHull

namespace PalomarConicHull
open Chapter08.ContinuousHull
variable {ι : Type*} [Fintype ι] {n : ℕ}

theorem exact_hull (D : Data ι n) (hD : Conic D) :
    projection D = convexHull ℝ (boundedUnion D) := by
  sorry

theorem compact_lift (D : Data ι n) (hK : ∀ i, IsClosed (D.cone i)) :
    IsCompact (fullLift D) := by
  sorry

theorem closed_hull (D : Data ι n) (hD : Conic D)
    (hK : ∀ i, IsClosed (D.cone i)) :
    closure (convexHull ℝ (boundedUnion D)) = projection D := by
  sorry

end PalomarConicHull
