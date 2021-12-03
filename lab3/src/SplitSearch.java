

import java.util.ArrayList;

import org.jacop.constraints.Alldiff;
import org.jacop.constraints.XeqC;
import org.jacop.constraints.XltY;
import org.jacop.constraints.XlteqC;
import org.jacop.constraints.XplusClteqZ;
import org.jacop.constraints.XplusYeqZ;
import org.jacop.core.IntVar;
import org.jacop.core.Store;
import org.jacop.search.DepthFirstSearch;
import org.jacop.search.IndomainMin;
import org.jacop.search.InputOrderSelect;
import org.jacop.search.PrintOutListener;
import org.jacop.search.Search;
import org.jacop.search.SelectChoicePoint;

public class SplitSearch {
    boolean trace = false;

    Store store;
    IntVar[] numbers;
    IntVar cost;

    int N = 0; /* This represents the total number of nodes*/
    int failedNodes = 0; 

    public SplitSearch(Store store) {
        this.store = store;
    }

    public void setVariablesToReport(IntVar nums) {        
        this.numbers = nums;
    }

    public void setCostVariable(IntVar c) {
        this.cost = c;
    }

    public boolean label(IntVar[] nums) {
        N++; // Another node has now been visited, increase total number of nodes

        if (trace) { // Report if trace enabled
            for (int i = 0; i < vars.length; i++) 
            System.out.print (vars[i] + " ");
            System.out.println ();
        }

        ChoicePoint choice = null; // new potential choice point
        boolean consistent;  // consistent variable

        if (costVariable != null) {
            try {
                if (costVariable.min() <= costValue - 1)
                    costVariable.domain.in(store.level, costVariable, costVariable.min(), costValue - 1);
                else
                    return false;
            } catch (FailException f) {
                return false;
            }
        }


        consistent = store.consistency();
        if (!consistent) {
            // Failed leaf of the search tree
            return false;
        } else { // consistent
    
            if (vars.length == 0) {
                // solution found; no more variables to label
        
                // update cost if minimization
                    if (costVariable != null)
                        costValue = costVariable.min();
            
                    reportSolution();
            
                    return costVariable == null; // true is satisfiability search and false if minimization
                }
        
                choice = new ChoicePoint(vars);
        
                levelUp();
        
                store.impose(choice.getConstraint());
        
                // choice point imposed.
                    
                consistent = label(choice.getSearchVariables());
        
                    if (consistent) {
                levelDown();
                return true;
                
            } else {
                failedNodes++;
        
                restoreLevel();
        
                store.impose(new Not(choice.getConstraint()));
        
                // negated choice point imposed.
                
                consistent = label(vars);
        
                levelDown();
        
                if (consistent) {
                    return true;
                } else {
                    return false;
                }
            }
        }

        return false;
    } 
}