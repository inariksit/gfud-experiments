The following will give you the GF AST (`at`) and create a PDF with visualized trees (`vat`) (see [result](./_gfud_ast_tmp.pdf)):

```
$ cat example.conllu | gf-ud ud2gf UDApp Eng UDS no-backups at vat
```

This will visualize the original UD:

```
$ cat example.conllu | gf-ud conll2svg 
```

ud2gf has a whole bunch of other options for seeing more of the intermediate steps. If you run it without the `at` flag, you get a bunch of output.

If ud2gf succeeds fully and the trees are correct, the option `vat` creates a PDF with the trees, and `lin` linearizes them. But if the full tree doesn't succeed, you can instead look at the intermediate trees and copy and paste subtrees into GF shell.

```
$ gf UDApp.pgf
                              
         *  *  *              
      *           *           
    *               *         
   *                          
   *                          
   *        * * * * * *       
   *        *         *       
    *       * * * *  *        
      *     *      *          
         *  *  *              

Languages: UDAppEng
UDApp> vt -view=open -format=pdf root_nsubj_xcomp (rootV_ (TTAnt TPast ASimul) PPos (UseV help_V)) (nsubj_ (DetCN theSg_Det (UseN action_N))) (xcompVP_ (ComplV launch_V (RelclNP (DetCN aSg_Det (AdjCN (AttributeNum (StrCard "79") day_N) (UseN (CompoundN street_N occupation_N)))) (aclRelclUDS_ (root_obl (rootV_ (TTAnt TPres ASimul) PPos (PassV describe_V)) (obl_ (PrepNP as_Prep (DetCN (DetQuant DefArt NumSg) (AdjCN (AdjOrd (OrdSuperl great_A)) (AdvCN (AdvCN (UseN challenge_N) (PrepNP to_Prep (DetCN (DetQuant (GenNP (UsePN China_PN)) NumPl) (AdjCN (PositA Communist_A) (UseN ruler_N))))) (PrepNP since_Prep (DetCN thePl_Det (UseN (AttributeNumPN (StrCard "1989") Tiananmen_PN protest_N))))))))))))))

4 msec

UDApp> l root_nsubj (rootV_ (TTAnt TPast ASimul) PPos (ComplV relaunch_V (DetCN (DetQuant (PossPron they_Pron) NumSg) (AdvCN (UseN protest_N) (PrepNP against_Prep (DetCN theSg_Det (AdvCN (AdvCN (UseN appointment_N) (PrepNP of_Prep (DetCN aPl_Det (AdjCN (PositA general_A) (AdvCN (UseN teacher_N) (PrepNP for_Prep (MassNP (UseN (CompoundCN (AdjCN (PositA physical_A) (UseN education_N)) work_N))))))))) (PrepNP in_Prep (DetCN aPl_Det (UseN school_N)))))))))) (nsubj_ (DetCN aPl_Det (AdvCN (UseN (ConjN and_Conj (BaseN student_N teacher_N))) (PrepNP of_Prep (MassNP (AdjCN (PositA physical_A) (UseN education_N)))))))
students and teachers of physical education relaunched their protest against the appointment of general teachers for physical education work in schools
```

____

### Issues

Numerals beyond 0–9 don't work out of the box (I hardcoded 79 and 1989). The grammar has the function `StrCard : String -> Card` which takes a string literal into a cardinal number. That function is disabled in the labels (if you enable it, you will get "ERROR: no constructor tree from <whatever word>"). Only use it for linearization.

For now I recommend postprocessing before linearization. Later you can have your own fork of gf-ud that does this when processing.

Postprocessing means e.g.

```
$ cat example.conllu | gf-ud ud2gf UDApp Eng UDS at no-backups | sed -E "s/\'([0-9]+)_Card\'/(StrCard \"\1\")/g"
```