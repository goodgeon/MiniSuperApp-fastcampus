import ModernRIBs

protocol FinanceHomeInteractable: Interactable, SuperPayDashboardListener {
  var router: FinanceHomeRouting? { get set }
  var listener: FinanceHomeListener? { get set }
}

protocol FinanceHomeViewControllable: ViewControllable {
  // TODO: Declare methods the router invokes to manipulate the view hierarchy.
  func addDashboard(_ view: ViewControllable)
}

final class FinanceHomeRouter: ViewableRouter<FinanceHomeInteractable, FinanceHomeViewControllable>, FinanceHomeRouting {
  
  private let superPayDashboardBuildable: SuperPayDashboardBuildable
  private var superPayDashboardRouting: SuperPayDashboardRouting?
  
  // TODO: Constructor inject child builder protocols to allow building children.
  init(interactor: FinanceHomeInteractable, 
       viewController: FinanceHomeViewControllable,
       superPayDashboardBuildable: SuperPayDashboardBuildable
  ) {
    self.superPayDashboardBuildable = superPayDashboardBuildable
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }
  
  func attachSuperPayDashboard() {
    guard self.superPayDashboardRouting == nil else { return }
    
    let router = superPayDashboardBuildable.build(withListener: interactor)
    let dashboard = router.viewControllable
    
    viewController.addDashboard(dashboard)
    
    self.superPayDashboardRouting = router
    attachChild(router)
  }
}
