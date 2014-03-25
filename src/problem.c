/*  Common problem input/output routines /structure
            25/Nov/2007   by Takeaki Uno  e-mail:uno@nii.jp, 
    homepage:   http://research.nii.ac.jp/~uno/index.html  */
/* This program is available for only academic use, basically.
   Anyone can modify this program, but he/she has to write down 
    the change of the modification on the top of the source code.
   Neither contact nor appointment to Takeaki Uno is needed.
   If one wants to re-distribute this code, please
    refer the newest code, and show the link to homepage of 
    Takeaki Uno, to notify the news about the codes for the users. */

/***************************************************/

#ifndef _problem_c_
#define _problem_c_

#include"problem.h"

#include"stdlib2.h"
#include"queue.h"
#include"itemset.h"

void PROBLEM_error (){
  ERROR_MES = "command explanation";
  EXIT;
}

/*************************************************************************/
/* PROBLEM and ITEMSET initialization */
/*************************************************************************/
void PROBLEM_init (LCM_PROBLEM *P){
  P->start_time = clock();
  RAND_INIT;
  ERROR_MES = NULL;

  P->problem = P->problem2 = 0;
  P->prog = 0;
  P->prog2 = 0;
  P->input_fname = P->input_fname2 = P->output_fname = P->output_fname2 = NULL;
  P->workdir = P->workdir2 = NULL;
  P->weight_fname = P->header_fname = P->table_fname = P->sc_fname = NULL;
  P->position_fname = P->position2_fname = NULL;
  P->outperm_fname = P->outperm_fname = NULL;

  P->root = 0;
  P->dir = P->edge_dir = 0;
  P->th = P->th2 = P->th3 = 0;
  P->ratio = P->ratio2 = 0;
  P->num = P->siz = P->dim = P->len = P->width = P->height = 0;
  P->rows = 0;
  P->clms = 0;
  P->gap_ub = INTHUGE;
  P->gap_lb = 0;
  P->xmax = P->ymax = P->pxmax = P->pymax = 0;
  P->cost = P->cost2 = 0;
  
  ITEMSET_init (&P->II);
  ITEMSET_init (&P->II2);

  P->vf = P->dep = NULL;
  P->ff = INIT_QUEUE;

  P->shift = NULL;
  P->occ_w = P->occ_pw = P->occ_w2 = P->occ_pw2 = NULL;
  P->buf = P->buf_org = NULL;
  P->buf_end = 0;
  
  P->itemjump = P->itemcand = P->vecjump = P->veccand = INIT_QUEUE;  // for delivery
  P->itemchr = P->vecchr = NULL;
  P->OQ = P->OQ2 = P->VQ = P->VQ2 = NULL;   // for delivery
  P->itemary = NULL;
  P->itemmark = P->itemflag = P->vecmark = P->vecflag = NULL;  // mark for vector
  P->occ_t = P->vecary = NULL;
  P->oo = INIT_QUEUE;
  P->vecw = NULL;
  
  P->pat = NULL;
  P->plen = P->perr = 0;

  P->B = INIT_BASE;

  TRSACT_init (&P->TT);
  TRSACT_init (&P->TT2);

  P->SG = INIT_SGRAPH;
  P->SG2 = INIT_SGRAPH;

    P->MM = INIT_MAT;
  P->MM2 = INIT_MAT;
  P->SM = INIT_SMAT;
  P->SM2 = INIT_SMAT;
  P->FF = INIT_SETFAMILY;
  P->FF2 = INIT_SETFAMILY;

    
#ifdef _barray_h_
  P->BA = INIT_BARRAY;
  P->BA2 = INIT_BARRAY;
#endif
}


/*************************************************************************/
/* PROBLEM load */
/*************************************************************************/
void PROBLEM_load (LCM_PROBLEM *P){
  int f=0;
  ITEMSET *II = &P->II;
/******************************/

    
    if ( P->TT.fname ){ TRSACT_load (&P->TT);       if (ERROR_MES) goto ERR; }
  if ( P->TT2.fname ){ TRSACT_load (&P->TT2);       if (ERROR_MES) goto ERR; }

    if ( P->SG.fname ){ SGRAPH_load (&P->SG);    if (ERROR_MES) goto ERR; }
  if ( P->SG2.fname ){ SGRAPH_load (&P->SG);    if (ERROR_MES) goto ERR; }


    if ( P->MM.fname ){ MAT_load (&P->MM);   if (ERROR_MES) goto ERR; }
  if ( P->MM2.fname ){ MAT_load (&P->MM2);    if (ERROR_MES) goto ERR; }
  if ( P->SM.fname ){ SMAT_load (&P->SM);    if (ERROR_MES) goto ERR; }
  if ( P->SM2.fname ){ SMAT_load (&P->SM2);    if (ERROR_MES) goto ERR; }
  if ( P->FF.fname ){ SETFAMILY_load (&P->FF);   if (ERROR_MES) goto ERR; }
  if ( P->FF2.fname ){ SETFAMILY_load (&P->FF2);   if (ERROR_MES) goto ERR; }
  if ( P->FF.wfname ){ SETFAMILY_load_weight (&P->FF);   if (ERROR_MES) goto ERR; }
  if ( P->FF2.wfname ){ SETFAMILY_load_weight (&P->FF2);   if (ERROR_MES) goto ERR; }
  if ( P->FF.cwfname ){ SETFAMILY_load_column_weight (&P->FF);   if (ERROR_MES) goto ERR; }
  if ( P->FF2.cwfname ){ SETFAMILY_load_column_weight (&P->FF2);   if (ERROR_MES) goto ERR; }
  if ( P->FF.rwfname ){ SETFAMILY_load_row_weight (&P->FF);   if (ERROR_MES) goto ERR; }
  if ( P->FF2.rwfname ){ SETFAMILY_load_row_weight (&P->FF2);   if (ERROR_MES) goto ERR; }


#ifdef _barray_h_
  if ( P->BA.fname ){ BARRAY_load (&P->BA);    if (ERROR_MES) goto ERR; }
  if ( P->BA2.fname ){ BARRAY_load (&P->BA2);    if (ERROR_MES) goto ERR; }
#endif
  if (P->input_fname){ f=1; print_mes (II, " input: %s", P->input_fname); }
  if (P->weight_fname){ f=1; print_mes (II, " weight: %s", P->weight_fname); }
  if (P->output_fname){ f=1; print_mes (II, " output to: %s",P->output_fname); }
  if ( f ) print_mes (II, "\n");

/******************************/

  if ( !ERROR_MES ) return;
  ERR:;
  PROBLEM_end (P);
  EXIT;
}

/* termination of problem */
void PROBLEM_end (LCM_PROBLEM *P){
  ITEMSET *II = &P->II;

  TRSACT_end (&P->TT);
  TRSACT_end (&P->TT2);

    SGRAPH_end (&P->SG);
  SGRAPH_end (&P->SG2);

    MAT_end (&P->MM);
  MAT_end (&P->MM2);
  SMAT_end (&P->SM);
  SMAT_end (&P->SM2);
  SETFAMILY_end (&P->FF);
  SETFAMILY_end (&P->FF2);

#ifdef _barray_h_
  BARRAY_end (&P->BA);
  BARRAY_end (&P->BA2);
#endif

/******************************/

  mfree (P->vf, P->dep);
  QUEUE_end (&P->ff);

  ITEMSET_end (II);
  ITEMSET_end (&P->II2);

  if ( P->occ_pw2 != P->occ_pw && P->occ_pw2 != P->occ_w2 ) free2 (P->occ_pw2);
  if ( P->occ_w2 != P->occ_w ) free2 (P->occ_w2);
  if ( P->occ_pw != P->occ_w ) free2 (P->occ_pw);
  mfree (P->shift, P->occ_t, P->occ_w);

  if ( P->OQ ) free2 (P->OQ[0].v);
  if ( P->OQ2 ) free2 (P->OQ2[0].v);
  if ( P->VQ ) free2 (P->VQ[0].v);
  if ( P->VQ2 ) free2 (P->VQ2[0].v);
  mfree (P->OQ, P->OQ2, P->VQ, P->VQ2, P->itemchr, P->vecchr);

  mfree (P->itemary, P->itemflag, P->itemmark, P->vecary, P->vecflag, P->vecmark, P->vecw);
  QUEUE_end (&P->itemcand);
  QUEUE_end (&P->itemjump);

  QUEUE_end (&P->veccand);
  QUEUE_end (&P->vecjump);
  QUEUE_end (&P->oo);

  free2 (P->buf_org);
 
#ifdef _undo_h_
  ALISTundo_end ();
#endif

  P->end_time = clock();
  if ( print_time_flag )
   print_mes (II, "computation_time= %3f\n", ((double)(P->end_time-P->start_time))/CLOCKS_PER_SEC);

  PROBLEM_init (P);
}

/* allocate arrays and structures */
void PROBLEM_alloc (LCM_PROBLEM *P, QUEUE_ID siz, QUEUE_ID siz2, size_t siz3, PERM *perm, int f){
  PERM *p;

    int j;

  if ( f&PROBLEM_SHIFT ) calloc2 (P->shift, siz+2, goto ERR);
  if ( f&PROBLEM_OCC_T ) calloc2 (P->occ_t, siz+2, goto ERR);
  if ( f&(PROBLEM_OCC_W+PROBLEM_OCC_PW) ) calloc2 (P->occ_w, siz+2, goto ERR);
  if ( f&PROBLEM_OCC_PW ) calloc2 (P->occ_pw, siz+2, goto ERR);
  else P->occ_pw = P->occ_w;
  if ( f&PROBLEM_OCC_W2 ){
    calloc2 (P->occ_w2, siz+2, goto ERR);
    if ( f&PROBLEM_OCC_PW ) calloc2 (P->occ_pw2, siz+2, goto ERR);
    else P->occ_pw2 = P->occ_w2;
  } else { P->occ_w2 = P->occ_w; P->occ_pw2 = P->occ_pw; }

  if ( f&PROBLEM_ITEMFLAG ) calloc2 (P->itemflag, siz+2, goto ERR);
  if ( f&PROBLEM_ITEMMARK ) calloc2 (P->itemmark, siz+2, goto ERR);
  if ( f&PROBLEM_ITEMARY ) calloc2(P->itemary, siz+2, goto ERR);
  if ( f&PROBLEM_ITEMCHR ) calloc2(P->itemchr, siz+2, goto ERR);
  if ( f&PROBLEM_ITEMJUMP ) QUEUE_alloc (&P->itemjump, siz+2);
  if ( f&PROBLEM_ITEMCAND ) QUEUE_alloc (&P->itemcand, siz+2);

  if ( f&PROBLEM_VECFLAG ) calloc2 (P->vecflag, siz2+2, goto ERR);
  if ( f&PROBLEM_VECMARK ) calloc2 (P->vecmark, siz2+2, goto ERR);
  if ( f&PROBLEM_VECARY ) calloc2 (P->vecary, siz2+2, goto ERR);
  if ( f&PROBLEM_VECCHR ) calloc2 (P->vecchr, siz2+2, goto ERR);
  if ( f&PROBLEM_VECJUMP ) QUEUE_alloc (&P->vecjump, siz2+2);
  if ( f&PROBLEM_VECCAND ) QUEUE_alloc (&P->veccand, siz2+2);
  if ( f&PROBLEM_VECW ) calloc2 (P->vecw, siz2+2, goto ERR);


    // set outperm
  if ( P->outperm_fname ){
    ARY_LOAD (p, int, j, P->outperm_fname, 1, EXIT);
    if ( perm ){
      FLOOP (j, 0, siz) perm[j] = p[perm[j]];
      free2 (p);
    } else perm = p;
  }
  ITEMSET_alloc (&P->II, P->output_fname, perm, siz, siz3);
  if ( P->II.target<siz && P->II.perm )
      FLOOP (j, 0, P->II.item_max){ if ( P->II.target == P->II.perm[j] ){ P->II.target = j; break; } }

#ifdef _undo_h_
  ALISTundo_init ();
#endif

  return;
  ERR:;
  PROBLEM_end (P);
  EXIT;
}

#endif


