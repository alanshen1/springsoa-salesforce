public class myClass { 

 public static final Id recordId = '0012E000026DWVZ';

  public void init() { 
    //Id id = ApexPages.currentPage().getParameters().get('id'); 
    Account account = [select id, Name FROM Account WHERE id = :recordId]; 
    account.Phone = '9078564723';
    update account; 
  }
}