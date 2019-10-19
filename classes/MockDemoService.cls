/**
 * Created by Chintan Shah on 10/18/2019.
 */

/**
 * this is the service that will be called by caller
 * it would be faked out during the testing framework.
 */
public with sharing class MockDemoService {

    public List<String> toUpper(List<String> inputs) {
        List<String> outputs = new List<String>();
        for(String input : inputs ) {
            outputs.add( input.toUpperCase() );
        }
        return outputs;
    }

    public String concat(List<String> inputs) {
        String output = null;
        for(String input : inputs ) {
            output = ( output == null ? '' : ( output + ' ' ) ) + input;
        }
        return output;
    }


}