#  <#Title#>
// internet checking
guard Connectivity.isConnected else {
print("internet issue!")
AlertView.internetAlert(view: self)
return
}

// for error handling use:
 errorHandler(err: err, view: self,spinner: self.spinner)
