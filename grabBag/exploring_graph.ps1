#installs all MG components
install-module Microsoft.graph
#lists permissions for running cmdlets in MG
find-MgGraphCommand -command get-mguser | select -first 1 -expandproperty permissions
#connects MG to Azure tenant based off of scopes/cmdlets from line 4, will require a msadmin acct; these accts do not function as Azure tenant accts, which are necessary for full MG functionality
connect-mggraph -scopes "user.read.all","group.readwrite.all"