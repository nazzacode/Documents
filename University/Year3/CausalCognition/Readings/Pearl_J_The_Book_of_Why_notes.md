# Pearl, J., (2018). The Book of Why
_Nathan Sharp | Oct 2020_

## Preface
_Claim:_ Causality has essentially been solved ("mathematised").

  - humans are hyper-optimised for causal inference
  - NS: where can we augment our causal inference weakpoints with computers? 

$P(A | B) \neq P(A | do(B))$
  
  - This is the difference between observing and acting. B can have many causes that effect A, do(B) is a randomised intervention.
  - in a world without do(B) "patients would avoid going to the doctor to reduce the probability of being seriously ill."

On _counterfactuals_:\
"Counterfactuals are the building blocks of moral behavior as well as scientific thought. The ability to reflect on one’s past actions and envision alternative scenarios is the basis of free will and social responsibility. The algorithmization of counterfactuals invites thinking machines to benefit from this ability and participate in this (until now) uniquely human way of thinking about the world."

  - NS: Interesting definition of free will.

On the primacy of _language_:\
"You cannot answer a question that you cannot ask, and you cannot ask a question that you have no words for." 

On _causal reasoning_ in strong AI:\
"A causal reasoning module will give machines the ability to reflect on their mistakes, to pinpoint weaknesses in their software, to function as moral entities, and to converse naturally with humans about their own choices and intentions."

## A Blueprint of Reality

  - Some queries may not be answerable under the current causal model, even after the collection of a arbitary ammount of data.
  - _Data_ is profoundly dumb about causal relationships.
  - Causal estimates are aproximate as data is only a finite sample from a theoretically infinite set.

On the utility of models:\
"If we are pushing the frontiers of scientific knowledge, where we do not have intuition to guide us"

_Claim:_ Randomised Controlled trials (RCT) are a real life tool for uncovering do(B).

Causation : “We may define a cause to be (1) an object followed by another, and where all the objects, similar to the first, are followed by objects similar to the second. Or, in other words, where, (2) if the first object had not been, the second never had existed.” _- Hume, D._

  - Hume really gave two definitions (Lewis, D.), the first of regularity and the second of the counterfactual (“if the first object had not been…”).
    - While philosophers and scientists had mostly paid attention to the regularity definition, Lewis argued that the counterfactual definition aligns more closely with human intuition: “We think of a cause as something that makes a difference, and the difference it makes must be a difference from what would have happened without it.”

## 1 The Ladder of Causation
_Claim:_ There are 3 levels of Causation: __Seeing (Association), Doing & Imagining__.

_Claim:_ these three levels are mathematically different.

__Activity:__ Seeing, Observing

__Questions:__
What if I see?, How are variables related?, How would seeing X change my belief in Y?\

__Examples:__ What does a symptom tell me about a disease?, What does a survey tell us about the election results?\

#### Notes
- > "seeing or observing entails detection of regularities in our environment." (The book of Why)\

- _Criticism:_ NS: Does seeing not require doing, e.g. moving as vision is embodied (kittens in barcode roundabout (Held & Hein, 1963)). Is he rather taking about raw 'dumb' data input? Similarly, does doing not require imagining, how else how could you have come to select the 'doing' action as an agent. It requires a model of the world which is by definition an imagination, whether you realise this or not.

- NS: Fundamentally _observational_ you are not intervening with the _specific_ situation beyond your processing of external data. 

### 2. Intervention

__Activity:__ Doing, Intervening

__Questions:__ _What if I do?_, What would Y be if I do X?, How can I make Y Happen?

__Examples:__ If I take aspirin will my headache be curred?, What if we ban cigarettes?

#### Notes
- > "Entails predicting the effects of deliberate alterations of the environment and choosing among these to to produce a desired outcome." (TBOW)\
- _Criticism:_ You can _random walk_ and _'do'_ without a suffcient internal model for deliberate manipulation.
- _Response:_ yes you can, but this is specifically about (causal) reasoning

### 3. Counterfactuals

__Activity:__ Imagining, retrospection, understanding.

__Questions:__ _What if I had done, Why?_ Was it X that caused why? What if X had not occurred? What if I had acted differently?

__Examples:__ Was it the aspirin that stopped my headache?, What If I had not smoked for the last 2 years?

#### Notes
- _NS:_ entails updating and restructuring your knowledge priors?

- NS: Maybe this is better understood as observation/intervention/counter-factual reasoning

### The Ladder of Causation cont. 
> "A sufficiently strong and accurate causal model can allow us to use-one (observational) data to answer rung-two (interventional) queries."

Captain shooting example. Seeing vs Doing. 
- 'doing' is in some sense breaking the ordinary causal structure of the world  

### On Probabilities and Causation 
Causality
  : X causes Y if X raises the probability of Y $(P( Y | X) > P(Y))$

_Problem:_ what if Y causes X or they have third variable Z causing both.

> "That is why I have not attempted to define causation anywhere in this book; definitions demand reduction, and reduction demands going to a lower rung"

> "Instead, I have pursued the ultimately more constructive progrm of explaining how to answer causal queries and what information is needed to answer them."

> "Nowhere in a [Euclid's] geoetry book will you find a definition of the terms  "point" and "line." Yet we can answer any and all queries about them on the basis of Euclid's axioms."

_Claim:_ Causality cannot be reduced to mere probability 

### 2 The genesis of Causal Inference

