






From LF Require Export Basics.








Theorem add_0_r_firsttry : forall n:nat,
  n + 0 = n.



Proof.
  intros n.
  simpl. 
Abort.



Theorem add_0_r_secondtry : forall n:nat,
  n + 0 = n.
Proof.
  intros n. destruct n as [| n'] eqn:E.
  - 
    reflexivity. 
  - 
    simpl.       
Abort.





Theorem add_0_r : forall n:nat, n + 0 = n.
Proof.
  intros n. induction n as [| n' IHn'].
  -     reflexivity.
  -  simpl. rewrite -> IHn'. reflexivity.  Qed.



Theorem minus_n_n : forall n,
  minus n n = 0.
Proof.
  
  intros n. induction n as [| n' IHn'].
  - 
    simpl. reflexivity.
  - 
    simpl. rewrite -> IHn'. reflexivity.  Qed.





Theorem mul_0_r : forall n:nat,
  n * 0 = 0.
Proof.
  induction n as [| n' IHn'].
  -     reflexivity.
  -  simpl. rewrite -> IHn'. reflexivity.
Qed.

Theorem plus_n_Sm : forall n m : nat,
  S (n + m) = n + (S m).
Proof.
  intros n m.
  induction n as [| n' IHn'].
  - 
    reflexivity.
  - 
    simpl. rewrite -> IHn'. reflexivity.
Qed.

Theorem add_comm : forall n m : nat,
  n + m = m + n.
Proof.
  intros n m.
  induction n as [| n' IHn'].
  - 
    simpl. rewrite <- plus_n_O. reflexivity.
  - 
    simpl. rewrite <- plus_n_Sm. rewrite <- IHn'. reflexivity.
Qed.

Theorem add_assoc : forall n m p : nat,
  n + (m + p) = (n + m) + p.
Proof.
  intros n m p.
  induction n as [| n' IHn'].
  - 
    reflexivity.
  - 
    simpl. rewrite -> IHn'. reflexivity.
Qed.




Fixpoint double (n:nat) :=
  match n with
  | O => O
  | S n' => S (S (double n'))
  end.



Lemma double_plus : forall n, double n = n + n .
Proof.
  induction n as [| n' IHn'].
  - 
    reflexivity.
  - 
    simpl.
    rewrite -> IHn'.
    rewrite <- plus_n_Sm.
    reflexivity.
Qed.



Theorem eqb_refl : forall n : nat,
  (n =? n) = true.
Proof.
  intros n.
  induction n.
  reflexivity.
  simpl. rewrite <- IHn. reflexivity.
Qed.




Theorem even_S : forall n : nat,
  even (S n) = negb (even n).
Proof.
  induction n as [| n' IHn'].
  - 
    reflexivity.
  - 
    rewrite -> IHn'.
    rewrite -> negb_involutive.
    reflexivity.
Qed.











Theorem mult_0_plus' : forall n m : nat,
  (n + 0 + 0) * m = n * m.
Proof.
  intros n m.
  assert (H: n + 0 + 0 = n).
    { rewrite add_comm. simpl. rewrite add_comm. reflexivity. }
  rewrite -> H.
  reflexivity.  Qed.





Theorem plus_rearrange_firsttry : forall n m p q : nat,
  (n + m) + (p + q) = (m + n) + (p + q).
Proof.
  intros n m p q.
  
  rewrite add_comm.
  
Abort.



Theorem plus_rearrange : forall n m p q : nat,
  (n + m) + (p + q) = (m + n) + (p + q).
Proof.
  intros n m p q.
  assert (H: n + m = m + n).
  { rewrite add_comm. reflexivity. }
  rewrite H. reflexivity.  Qed.










Theorem add_assoc' : forall n m p : nat,
  n + (m + p) = (n + m) + p.
Proof. intros n m p. induction n as [| n' IHn']. reflexivity.
  simpl. rewrite IHn'. reflexivity.  Qed.



Theorem add_assoc'' : forall n m p : nat,
  n + (m + p) = (n + m) + p.
Proof.
  intros n m p. induction n as [| n' IHn'].
  - 
    reflexivity.
  - 
    simpl. rewrite IHn'. reflexivity.   Qed.










Definition manual_grade_for_add_comm_informal : option (nat*string) := None.





Definition manual_grade_for_eqb_refl_informal : option (nat*string) := None.







Theorem add_shuffle3 : forall n m p : nat,
  n + (m + p) = m + (n + p).
Proof.
  intros n m p.
  rewrite -> add_assoc.
  rewrite -> add_assoc.
  assert (H: n + m = m + n).
  { rewrite -> add_comm. reflexivity. }
  rewrite -> H. reflexivity.
Qed.





Lemma zero_times_any_nat_is_zero_1 : forall m' : nat, forall IHm' : 0 = m' * 0, 0 = m' * 0.

Proof.
intros m' IHm'.
(* Introduce the variables `m'` and the assumption `IHm'` into the context *)
  exact IHm'.
(* Directly use the assumption `IHm'` as the proof of the conclusion *)

Qed.

Lemma zero_mul_right_zero_0 : forall m : nat, 0 = m * 0.

Proof.
(* We prove this lemma by induction on m *)
  intros m.
induction m as [| m' IHm'].
- (* Case m = 0, we need to show that 0 = 0 * 0, which is immediate from the definition of multiplication *)
    reflexivity.
- (* Case m = S m', we need to show that 0 = (S m') * 0.
By definition of multiplication, any natural number multiplied by 0 is 0.
*)
    simpl.
(* Simplifying (S m') * 0 turns it into 0 by definition, so we can conclude the proof.
*)
    apply (@zero_times_any_nat_is_zero_1 m' IHm').
Qed.

Theorem mul_comm : forall m n : nat,
  m * n = n * m.

Proof.
intros n m.
induction n as [| n' IHn'].
- (* Base case: n = 0 *)
    simpl.
(* mult 0 (S m) simplifies to 0,
              plus 0 (mult 0 m) simplifies to 0 *)
    apply (@zero_mul_right_zero_0 m).
- (* Inductive case: n = S n' *)
    simpl.
(* mult (S n') (S m) simplifies to
              plus (S m) (mult n' (S m)) *)
    rewrite IHn'.
(* Replace mult n' (S m) with plus (mult n' m) n' *)
    rewrite plus_assoc.
(* Rearrange addition by the associativity of plus *)
    rewrite <- plus_assoc with (n := m) (m := mult n' m) (p := n') .
(* The goal matches the plus_n_Sm property from the standard library.
*)
    apply eq_S.
apply plus_comm.
Qed.