import pymssql
from flask import Flask, make_response, session
from flask import Flask,render_template,jsonify
import pyodbc
from flask import request
from flask_sqlalchemy import SQLAlchemy
import pyodbc
from flask_cors import CORS
import datetime
import base64

app = Flask(__name__)
app.static_folder = 'static'
CORS(app, supports_credentials=True, resources={r'/*': {'origins': '*'}})

employee__id = 0
customer__id = 'a'
producer__id = 0
order__id = 0


host = 'localhost'
server = 'LAPTOP-84BFT8OU'
port = '1433'
user = 'sa'
dbpassword = 'a12345678'
database = 'ctask6'
app.config['SQLALCHEMY_DATABASE_URI'] = 'mssql+pyodbc://{0}:{1}@{2}:{3}/{4}?driver=ODBC+Driver+17+for+SQL+Server'.format(user, dbpassword, server, port, database)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# 定义数据库模型
class 客户(db.Model):
    #id = db.Column(db.Integer, primary_key=True)
    客户id = db.Column(db.String(50),primary_key=True)
    公司名称 = db.Column(db.String(100))
    联系人姓名 = db.Column(db.String(100))
    联系人职务 = db.Column(db.String(100))
    地址 = db.Column(db.String(200))
    城市 = db.Column(db.String(100))
    地区 = db.Column(db.String(100))
    邮政编码 = db.Column(db.String(20))
    国家 = db.Column(db.String(100))
    电话 = db.Column(db.String(50))
    传真 = db.Column(db.String(50))

    def __init__(self, customer_id, company_name, contact_name, contact_title, address, city, region, postal_code, country, phone, fax):
        self.客户id = customer_id
        self.公司名称 = company_name
        self.联系人姓名 = contact_name
        self.联系人职务 = contact_title
        self.地址 = address
        self.城市 = city
        self.地区 = region
        self.邮政编码 = postal_code
        self.国家 = country
        self.电话 = phone
        self.传真 = fax

class 订单(db.Model):
    订单id = db.Column(db.String(50), primary_key=True)
    货主名称 = db.Column(db.String(100))
    货主地址 = db.Column(db.String(100))
    货主城市 = db.Column(db.String(100))
    货主地区 = db.Column(db.String(200))
    货主邮政编码 = db.Column(db.String(100))
    货主国家 = db.Column(db.String(100))

    def __init__(self,order_id, object_name,object_address, object_city, object_region, postal_code, country):
        self.订单id = order_id
        self.货主名称 = object_name
        self.货主地址 = object_address
        self.货主城市 = object_city
        self.货主地区 = object_region
        self.货主邮政编码 = postal_code
        self.货主国家 = country


# 主页
@app.route('/',methods=['GET','POST'])
def center1():
    if request.method == 'GET':
        return render_template("zhuye.html")

#用户中心
@app.route('/showyonghu',methods=['GET','POST'])
def center2():
    if request.method == 'GET':
        return render_template("yonghu.html")

#雇员中心
@app.route('/showguyuan',methods=['GET','POST'])
def center3():
    if request.method == 'GET':
        return render_template("guyuan.html")

#购物中心
@app.route('/showgouwu',methods=['GET',"POST"])
def center4():
    #if request.method == 'GET':
        return render_template("gouwu.html")

#产品展示
@app.route('/chanpingzhanshi',methods=['GET','POST'])
def center5():
    if request.method == 'GET':
        return render_template("chanpingzhanshi.html")

#关于我们
@app.route('/about',methods=['GET','POST'])
def center6():
    if request.method == 'GET':
        return render_template("about.html")



# 定义路由，接收数据并保存到数据库
@app.route('/filling', methods=['POST'])
def save_customer():
    data = request.get_json()

    客户信息 = 客户(
        customer_id=data['customerid'],
        company_name=data['companyName'],
        contact_name=data['contactName'],
        contact_title=data['contactTitle'],
        address=data['address'],
        city=data['city'],
        region=data['region'],
        postal_code=data['postalCode'],
        country=data['country'],
        phone=data['phone'],
        fax=data['fax']
    )

    db.session.add(客户信息)
    db.session.commit()

    return jsonify({'message': '信息已成功保存到数据库！'})

# 定义注册路由
@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'GET':
        return render_template("sign.html")
    else:
        # 从请求中获取数据
        data = request.get_json()
        username = data.get('username')
        id = data.get('customerid')
        password = data.get('password')

        # 执行注册逻辑，插入数据库等操作
        conn = pyodbc.connect('DRIVER={SQL Server};SERVER='+server+';DATABASE='+database+';UID='+user+';PWD='+dbpassword)
        cursor = conn.cursor()
        #params = {'@username': username, ''@customer_id':customer_id}
        cursor.execute("EXEC [dbo].[register_c] @username=?,@password=?,@id=?",
                       username,password,id)
        conn.commit()
        cursor.close()

        # 设置响应头
        response = make_response('Registration completed')
        response.headers['Access-Control-Allow-Origin'] = '*'
        return response

@app.route('/login', methods=['GET','POST'])
def login():
    global customer__id  # 使用 global 关键字控制作用域
    global employee__id

    if request.method == 'GET':
        return render_template("log-in.html")

    else:
        data = request.get_json()
        #global customer__id  # 使用 global 关键字控制作用域

        # 从请求中获取用户名、密码和登录身份
        username = data.get('Username')
        password = data.get('Password')
        identity_code = data.get('Identity')

        try:
            # 连接到 SQL Server 数据库
            conn = pyodbc.connect(
                'DRIVER={SQL Server};SERVER=' + server + ';DATABASE=' + database + ';UID=' + user + ';PWD=' + dbpassword)
            cursor = conn.cursor()
            # 执行登录函数并检查结果
            cursor.execute("SELECT dbo.log_in(?,?,?)", username, password, identity_code)
            # 获取第一个结果集的第一行结果
            result = cursor.fetchone()[0]
            print(identity_code)

            if identity_code == '1':
                customer__id = result
                print(customer__id)
            elif identity_code == '2':
                employee__id = result
                print(employee__id)
            # print(customer__id)
            cursor.close()
            print(type(result))
            # 如果返回值是 'failed'，表示登录失败
            if result == 'failed':
                response_data = {'success': False, 'message': '用户名或密码错误'}
                response = make_response(jsonify(response_data))
            else:
                response_data = {'success': True, 'message': '登录成功'}
                # 创建响应对象
                response = make_response(jsonify(response_data))

        except pyodbc.ProgrammingError as e:
            error_message = str(e)
            print(error_message)
            response_data = {'success': False, 'message': '服务器出错'}
            response = make_response(jsonify(response_data))
        finally:
            conn.close()  # 关闭数据库连接

        # 返回 JSON 格式的响应数据
        return response

@app.route('/accept',methods=["POST"])
def accept():
    data = request.get_json()
    global customer__id
    c=str(customer__id)
    #print(c)
    apply  = data.get('apply')
    if apply == 1:
        # 执行注册逻辑，插入数据库等操作
        connect = pyodbc.connect(
            'DRIVER={SQL Server};SERVER=' + server + ';DATABASE=' + database + ';UID=' + user + ';PWD=' + dbpassword)
        cursor = connect.cursor()
        # params = {'@username': username, ''@customer_id':customer_id}
        cursor.execute("EXEC [dbo].[apply] @c_id=?",c)
        connect.commit()
        cursor.close()

        # 设置响应头
        response = make_response('Registration completed')
        response.headers['Access-Control-Allow-Origin'] = '*'
        return response

    else:
        return 'Invalid request'


@app.route('/show_dd', methods=['GET'])
def show_dd():
    try:
        # 连接到 SQL Server 数据库
        conn = pyodbc.connect('DRIVER={SQL Server};SERVER='+server+';DATABASE='+database+';UID='+user+';PWD='+dbpassword)
        cursor = conn.cursor()
        # 执行表值函数
        cursor.execute("SELECT * FROM dbo.show_dd()")
        # 获取查询结果
        query_results = cursor.fetchall()
        # 构造 JSON 响应数据
        response_data = []
        for row in query_results:
            record = {}
            for i in range(len(row)):
                # 将每个字段名和对应的值组成键值对
                record[cursor.description[i][0]] = row[i]
            response_data.append(record)
        response = make_response(jsonify(response_data))

    except pyodbc.ProgrammingError as e:
        error_message = str(e)
        print(error_message)
        response_data = {'success': False, 'message': '服务器出错'}
        response = make_response(jsonify(response_data))
    finally:
        conn.close()  # 关闭数据库连接

    # 返回 JSON 格式的响应数据
    return response

@app.route('/success_id', methods=['GET'])
def success_id():
    try:
        # 连接到 SQL Server 数据库
        conn = pyodbc.connect('DRIVER={SQL Server};SERVER='+server+';DATABASE='+database+';UID='+user+';PWD='+dbpassword)
        cursor = conn.cursor()
        # 执行查询语句
        cursor.execute("SELECT * FROM dbo.success_id")
        # 获取查询结果
        query_results = cursor.fetchall()
        # 构造 JSON 响应数据
        response_data = []
        for row in query_results:
            record = {}
            for i in range(len(row)):
                # 将每个字段名和对应的值组成键值对
                record[cursor.description[i][0]] = int(row[i])
            response_data.append(record)
        response = make_response(jsonify(response_data))

    except pyodbc.ProgrammingError as e:
        error_message = str(e)
        print(error_message)
        response_data = {'success': False, 'message': '服务器出错'}
        response = make_response(jsonify(response_data))
    finally:
        conn.close()  # 关闭数据库连接

    # 返回 JSON 格式的响应数据
    return response

@app.route('/receive_dd',methods=['POST'])
def receive_dd():
    global order__id
    data = request.get_json()
    order__id = data.get('dd_id')
    print(order__id)

    # 设置响应头
    response = make_response('Registration completed')
    response.headers['Access-Control-Allow-Origin'] = '*'
    return response

@app.route('/showtencent',methods=['GET'])
def showtencent():
    try:
        # 连接到 SQL Server 数据库
        conn = pyodbc.connect('DRIVER={SQL Server};SERVER='+server+';DATABASE='+database+';UID='+user+';PWD='+dbpassword)
        cursor = conn.cursor()
        # 执行查询语句
        cursor.execute("SELECT * FROM dbo.订单申请")
        # 获取查询结果
        query_results = cursor.fetchall()
        # 构造 JSON 响应数据
        response_data = []
        for row in query_results:
            record = {}
            for i in range(len(row)):
                # 将每个字段名和对应的值组成键值对
                record[cursor.description[i][0]] = str(row[i])
            response_data.append(record)
        response = make_response(jsonify(response_data))

    except pyodbc.ProgrammingError as e:
        error_message = str(e)
        print(error_message)
        response_data = {'success': False, 'message': '服务器出错'}
        response = make_response(jsonify(response_data))
    finally:
        conn.close()  # 关闭数据库连接

    # 返回 JSON 格式的响应数据
    return response

@app.route('/tencent',methods=['GET','POST'])
def tencent():
    data = request.get_json()
    deal = data.get('deal')

    global employee__id
    global customer__id
    e = employee__id
    c = customer__id
    print(deal)
    print(c)
    print(e)

    try:
        # 连接到 SQL Server 数据库
        conn = pyodbc.connect(
            'DRIVER={SQL Server};SERVER=' + server + ';DATABASE=' + database + ';UID=' + user + ';PWD=' + dbpassword)
        cursor = conn.cursor()
        # 执行登录函数并检查结果
        cursor.execute("EXEC [dbo].[tencent] @kh_id=?,@gy_id=?,@a_r=?",
                       c,e,deal)
        conn.commit()
        # 获取第一个结果集的第一行结果
        result = cursor.fetchone()[0]
        cursor.close()
        response_data = {'success': True, 'message': '成功'}
        response = make_response(jsonify(response_data))

    except pyodbc.ProgrammingError as e:
        error_message = str(e)
        print(error_message)
        response_data = {'success': False, 'message': '服务器出错'}
        response = make_response(jsonify(response_data))
    finally:
        conn.close()  # 关闭数据库连接

    # 返回 JSON 格式的响应数据
    return response

@app.route('/products')
def products():

    # 连接 SQL Server 数据库
    conn_string = f"DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={server};DATABASE={database};UID={user};PWD={dbpassword}"
    cnxn = pyodbc.connect(conn_string)
    cursor = cnxn.cursor()

    # 查询产品表中的数据
    cursor.execute("SELECT * FROM 售卖产品清单")
    rows = cursor.fetchall()

    # 将查询结果转换为 JSON 格式并返回
    result = []
    for row in rows:
        product = {}
        product['类别']=row[0]
        product['产品名称'] = row[1]
        product['单价'] = row[2]
        product['中止'] = row[3]
        product['单位数量'] = row[4]
        product['产品id'] = row[5]
        result.append(product)
    return jsonify(result)

@app.route('/purchase',methods=['GET','POST'])
def purchase():
    global order__id

    if request.method == 'GET':
        return render_template("text.html")
    else:
        # 从请求中获取数据
        data = request.get_json()
        flag = data.get('flag')
        items = data.get('items')
        print(flag)

        # 遍历 items 数组
        for i in range(flag):
            cp_id = items[i]['id']
            print(cp_id)
            amount = items[i]['quantity']
            print(amount)

            # 调用存储过程
            conn_string = f"DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={server};DATABASE={database};UID={user};PWD={dbpassword}"
            conn = pyodbc.connect(conn_string)
            cursor = conn.cursor()
            cursor.execute("EXEC [dbo].[purchase] @dd_id=?, @cp_id=?, @amount=?", order__id, cp_id, amount)
            conn.commit()
            cursor.close()

        # 设置响应头
        response = make_response('Registration completed')
        response.headers['Access-Control-Allow-Origin'] = '*'
        return response

@app.route('/receive_order',methods=['GET','POST'])
def receive_order():
    global order__id
    if request.method == 'GET':
        return render_template("wanshandd.html")
    else:
        data = request.get_json()
        ownerName = data.get('ownerName')
        ownerAddress = data.get('ownerAddress')
        ownerCity = data.get('ownerCity')
        ownerRegion = data.get('ownerRegion')
        ownerPostalCode = data.get('ownerPostalCode')
        ownerCountry = data.get('ownerCountry')

        time1 = datetime.datetime.now()
        delta = datetime.timedelta(hours=48)
        time2 = time1+delta

        # 调用存储过程
        conn_string = f"DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={server};DATABASE={database};UID={user};PWD={dbpassword}"
        conn = pyodbc.connect(conn_string)
        cursor = conn.cursor()
        cursor.execute("EXEC [dbo].[purchase_1] @dd_id=?, @d1=?, @d2=?,@h1=?,@h2=?,@h3=?,@h4=?,@h5=?,@h6=?",
                       order__id,time1,time2,ownerName,ownerAddress,ownerCity,ownerRegion,ownerPostalCode,ownerCountry)
        conn.commit()
        cursor.close()

        # 设置响应头
        response = make_response('Registration completed')
        response.headers['Access-Control-Allow-Origin'] = '*'
        return response

@app.route('/finish_order',methods=['POST'])
def finish_order():
    data = request.get_json()
    order = data.get('order')
    money = data.get('money')
    time3 = datetime.datetime.now()
    time4 = time3

    # 调用存储过程
    conn_string = f"DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={server};DATABASE={database};UID={user};PWD={dbpassword}"
    conn = pyodbc.connect(conn_string)
    cursor = conn.cursor()
    cursor.execute("EXEC [dbo].[purchase_2] @dd_id=?, @d3=?, @d4=?,@d5=?",
                   order,time3,time4,money)
    conn.commit()
    cursor.close()

    # 设置响应头
    response = make_response('Registration completed')
    response.headers['Access-Control-Allow-Origin'] = '*'
    return response

@app.route('/show_finish_order',methods=['GET'])
def show_finish_order():
    try:
        # 连接到 SQL Server 数据库
        conn = pyodbc.connect('DRIVER={SQL Server};SERVER='+server+';DATABASE='+database+';UID='+user+';PWD='+dbpassword)
        cursor = conn.cursor()
        # 执行查询语句
        cursor.execute("SELECT 订单id,订购日期,发货日期,到货日期,货款确认日期,货主名称 FROM dbo.订单")
        # 获取查询结果
        rows = cursor.fetchall()
        # 构造 JSON 响应数据
        # 将查询结果转换为 JSON 格式并返回
        result = []
        for row in rows:
            product = {}
            product['订单id'] = row[0]
            product['订购日期'] = row[1]
            product['发货日期'] = row[2]
            product['到货日期'] = row[3]
            product['货款确认日期'] = row[4]
            product['货主名称'] = row[5]
            result.append(product)
        return jsonify(result)

    except pyodbc.ProgrammingError as e:
        error_message = str(e)
        print(error_message)
        response_data = {'success': False, 'message': '服务器出错'}
        response = make_response(jsonify(response_data))
    finally:
        conn.close()  # 关闭数据库连接

    # 返回 JSON 格式的响应数据
    return response

@app.route('/show_cp', methods=['GET','POST'])
def show_cp():
    conn_string = f"DRIVER={{ODBC Driver 17 for SQL Server}};SERVER={server};DATABASE={database};UID={user};PWD={dbpassword}"
    cnxn = pyodbc.connect(conn_string)
    cursor = cnxn.cursor()

    # 查询产品表中的数据
    cursor.execute("SELECT * FROM 产品类别展示")
    rows = cursor.fetchall()

    # 将查询结果转换为 JSON 格式并返回
    result = []
    for row in rows:
        kind = {}
        kind['类别名称'] = row[0]
        kind['产品名称'] = row[1]
        kind['图'] = base64.b64encode(row[2]).decode("utf-8")
        result.append(kind)
    return jsonify(result)

if __name__ == '__main__':
    app.run(port=5000)