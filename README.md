# EasyCloudStorage

    文档-- 初始化
## 分支说明
master分支：存放项目稳定版本的代码。按照要求，我们每周迭代一个版本，所以，我们每周都需要更新一次master分支为最新版本。<br>
<br>
develop分支：我们日常开发的项目代码存放在该分支中。<br>
<br>
其他的临时分支：这是个人分支，用来开发某一特定功能。分支命名尽量贴切，比如，我正在开发登录功能，就可以新建一个命为 login 的分支,<br>
然后，在该分支上进行开发，等到功能开发完成，并测试无误后，将当前分支整合到develop分支上。<br>
<br>

## 关于使用github进行团队开发的流程
详细流程见共享文档 "github团队开发流程"
<br><br><br>

    文档-- “项目结构初始化 + Spring配置 + 测试代码” 之后的更新
## 项目结构
src/main/java : 源代码目录 <br/>
src/main/java/easycloudStorage/pojo : 模型类包,对应数据库中的一张表<br/>
src/main/java/easycloudStorage/mapper : 持久层类包，使用MyBatis实现数据持久化<br/>
src/main/java/easycloudStorage/service : 服务层类包（业务逻辑，给controller使用的）<br/>
src/main/java/easycloudStorage/controller : 控制器类包（用于接受请求，处理请求，然后将数据返回给视图）<br/>

src/main/resources : 存放各种配置文件（spring、sql）<br/>
src/main/resources/mapper : 存放具体的与数据库交互的代码
src/main/webapp : web容器根目录。<br/>
src/main/webapp/WEB-INFO/jsp ： 用于存放jsp文件<br/>

.gitingore : 里面写了上传到github时，会自动过滤掉的文件<br/>

pom.xml : 项目包依赖管理，可自行添加需要的包<br/>
