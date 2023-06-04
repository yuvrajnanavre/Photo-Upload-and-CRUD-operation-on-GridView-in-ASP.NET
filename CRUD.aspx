<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CRUD.aspx.cs" Inherits="InfobridgeSolution_Task.CRUD" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
<%--    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script>
        $(function () {
            $("#fileuploadEmpImage").change(function () {
                var FileType = ["jpeg", "gif", "jpg", "png", "bmp"];
                if ($.inArray($(this).val().split('.').pop().toLowerCase(), FileType) == -1)
                {
                    $("#Label1").text("Upload only Image Types");
                    $("#Label1").css('color', 'Red');
                    $("#fileuploadEmpImage").val("");
                    $("#Submit").attr('disabled', true);
                }
                else
                {
                    $("#Submit").attr('disabled', false);
                    $("#Label1").text("");
                }
            })
        })
    </script>--%>
    <style type="text/css">
        .auto-style1 {
            height: 19px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
       <ContentTemplate>
         <asp:Panel runat="server" Font-Size="Small" Font-Bold="False">
                       
        <div>
           
        <h3>  
            &nbsp;CRUD Operation</h3>  
            <table>  

                <tr>  
                    <td>  
                        Name:</td>  
                    <td>  
                        <asp:TextBox ID="Name" runat="server" ></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ValidationGroup="Source1" runat="server" ErrorMessage="Please Enter Name" ControlToValidate="Name" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                    </td>  

                </tr>  

                <tr>  
                    <td>  
                        Date of Birth:&nbsp;&nbsp;&nbsp; </td>  
                    <td>  

                        <asp:TextBox ID="DOB" runat="server"  TextMode="Date"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="Source1" ErrorMessage="Please Enter DOB" ControlToValidate="DOB" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        
                    </td>  

                    

                </tr>  
                <tr>  
                    <td>  
                        Sex:</td>  
                    <td>  
                        <asp:RadioButtonList ID="RadioButtonList1" runat="server" >
                            <asp:ListItem>Male</asp:ListItem>
                            <asp:ListItem>Female</asp:ListItem>
                            <asp:ListItem>Other</asp:ListItem>

                        </asp:RadioButtonList>
                        
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="Source1" runat="server" ErrorMessage="Please Select Sex" ControlToValidate="RadioButtonList1" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>

                    </td>  

                      
                </tr> 
                <tr>  
                    <td>  
                        Phone:</td>  
                    <td>
                        <br/>
                        <asp:TextBox ID="Phone" runat="server"  ></asp:TextBox>
                        
                        
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="Phone" ErrorMessage="Please Enter Phone" ForeColor="Red" ValidationGroup="Source1" Display="Dynamic"></asp:RequiredFieldValidator>
                        
                        
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="Phone" ErrorMessage="Please Enter 10 digit mobile number" ForeColor="Red" ValidationExpression="[0-9]{10}" SetFocusOnError="True" ValidationGroup="Source"></asp:RegularExpressionValidator>
                        <br/>
                    </td>  

                </tr>  
                <tr>  
                    <td>  
                        Address:</td>  
                    <td>  
                        <asp:TextBox ID="Address" runat="server" textmode="MultiLine" Width="300px" Height="40px" ></asp:TextBox>
                        
                       <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Please Enter Address" ControlToValidate="Address" ValidationGroup="Source1" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                    </td>  

                </tr>  
                <tr>  
                    <td>  
                        Photo:</td>  
                    <td>  
                      <asp:FileUpload ID="fileuploadEmpImage" runat="server" Width="180px" accept=".png,.jpg,.jpeg"/>   
                       
                         
                        
                       <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Please Choose Image" ValidationGroup="Source1" ControlToValidate="fileuploadEmpImage" ForeColor="Red" Display="Dynamic"></asp:RequiredFieldValidator>
                        <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ControlToValidate="fileuploadEmpImage" ErrorMessage="Please select .jpeg|.JPEJ|.png|.PNG|.JPG|.jpg file" ValidationExpression="/^(([a-zA-Z]:)|(\\{2}\w+)\$?)(\\(\w[\w].*))+(.jpeg|.JPEG|.gif|.GIF|.png|.PNG|.JPG|.jpg|.bitmap|.BITMAP)$/" SetFocusOnError="True" ForeColor="Red" ValidationGroup="Source1" ></asp:RegularExpressionValidator>--%>
                         
                        <%--<asp:Label ID="Label7" runat="server" ForeColor="Red" Text="Label"></asp:Label>--%>
                         
                    </td>  

                </tr>  
                
                <tr>  
                    <td class="auto-style1">
                        </td>  
                                        <td class="auto-style1">  
                        </td>  
                                          
                </tr>                <tr>  
                    <td>
                        &nbsp;</td>  
                                        <td>  
                                            <asp:Button ID="Submit" runat="server" ValidationGroup="Source1"  CausesValidation="true" Text="Submit" OnClick="Submit_Click" />
                    </td>  
                                          
                </tr>  
                                <tr>  
                    <td>
                        &nbsp;</td>  
                                          
                                        <td>  
                        &nbsp;</td>  
                </tr>
                     
            </table>  </div> 
        </asp:Panel>
 <div class="GridView"> 
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="Id"
         OnRowEditing="OnRowEditing" OnRowCancelingEdit="OnRowCancelingEdit"
        OnRowUpdating="update" OnRowDeleting="OnRowDeleting" EmptyDataText="No records has been added." 
                    Height="161px" style="margin-top: 15px" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4">
                    <Columns>
                        <asp:TemplateField HeaderText="ID">
                            <ItemTemplate>
                                <asp:Label ID="Label6" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Name">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtName" runat="server" Text='<%# Eval("Name") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>  
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date Of Birth">
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDateOfBirth" runat="server" TextMode="Date" Text='<%# Eval("DateOfBirth") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Eval("DateOfBirth") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Sex">
                                <EditItemTemplate>
                                    <br />
                                    <asp:RadioButtonList ID="RadioButtonList2" runat="server" SelectedValue='<%# Eval("Sex") %>'>
                                        <asp:ListItem>Male</asp:ListItem>
                                        <asp:ListItem>Female</asp:ListItem>
                                        <asp:ListItem>Other</asp:ListItem>
                                    </asp:RadioButtonList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("Sex") %>'></asp:Label>
                                </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Phone">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtPhone" runat="server" Text='<%# Eval("Phone") %>'></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator10" runat="server" ControlToValidate="txtPhone" ErrorMessage="Please Enter 10 digit mobile number" ForeColor="Red" ValidationExpression="[0-9]{10}" SetFocusOnError="True" ValidationGroup="grid1"></asp:RegularExpressionValidator>
                        
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("Phone") %>'></asp:Label>
                                </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Address">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtAddress" runat="server" textmode="MultiLine" Width="300px" Height="40px" ValidationGroup="grid1" Text='<%# Eval("Address") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="Label5" runat="server" Text='<%# Eval("Address") %>'></asp:Label>
                                </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Image">
                                
                            <EditItemTemplate>
                                <asp:FileUpload ID="txtFileUpload" runat="server" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator11" runat="server" ControlToValidate="txtFileUpload" ErrorMessage="Please select image file" SetFocusOnError="True" ValidationExpression="/^(([a-zA-Z]:)|(\\{2}\W+)\$?)(\\(\W[\W].*))+(.jpeg|.JPEJ|.png|.PNG|.JPG|.jpg)$/"  Display="Dynamic" ForeColor="Red" ValidationGroup="grid1"></asp:RegularExpressionValidator>
                       
                            </EditItemTemplate>
                                
                            <ItemTemplate>
                                <asp:Image ID="Image1" runat="server" ImageUrl='<%# "EmployeeImageHandler.ashx?Id="+ Eval("Id") %>'  
                            Height="150px" Width="150px"/>
                            </ItemTemplate>
                                
                        </asp:TemplateField>
                        <asp:CommandField ButtonType="Image" 
                ShowEditButton="True" CancelImageUrl="~/Images/cancel.png" EditImageUrl="~/Images/edit_display.gif" HeaderText="Update" UpdateImageUrl="~/Images/Update.gif" ValidationGroup="grid1" >
            <ControlStyle Height="20px" Width="20px" />
            <FooterStyle Wrap="True" />
            <HeaderStyle Wrap="True" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="True" />
            </asp:CommandField>
            <asp:CommandField ButtonType="Image" DeleteImageUrl="~/Images/Deletenew.jpg" HeaderText="Delete" ShowDeleteButton="True">
            <ControlStyle Height="20px" Width="20px" />
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Wrap="False" />
            </asp:CommandField>
        </Columns>
                <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                <RowStyle BackColor="White" ForeColor="#003399" />
                <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                <SortedAscendingCellStyle BackColor="#EDF6F6" />
                <SortedAscendingHeaderStyle BackColor="#0D4AC4" />
                <SortedDescendingCellStyle BackColor="#D6DFDF" />
                <SortedDescendingHeaderStyle BackColor="#002876" />
    </asp:GridView>

             </div>
        </ContentTemplate>
    </form>
</body>
</html>
